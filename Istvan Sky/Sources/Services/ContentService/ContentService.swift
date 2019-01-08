//
//  ContentService.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation
import Firebase

protocol ContentService {
    func menuItems() -> [BasicItem]?
    func topItem(type: BasicItemType) -> BasicItem?
    func topItem(type: BasicItemType, data: [BasicItem]?) -> BasicItem?
    func update(completion: (() -> Void)?)
}

extension Notification.Name {
    static let didReceiveNewData = Notification.Name("didReceiveNewData")
}

class ContentServiceImp: ContentService {
    var appData: [BasicItem]?
    let storage = Storage.storage()
    
    public func menuItems() -> [BasicItem]? {
        return appData
    }

    public func topItem(type: BasicItemType) -> BasicItem? {
        return topItem(type: type, data: appData)
    }

    public func topItem(type: BasicItemType, data: [BasicItem]?) -> BasicItem? {
        if let data = data {
            return data.first(where: {$0.type == type})
        }
        
        return nil
    }

    init() {
        loadData()
        update()
    }
    
    private func loadData() {
        if loadAppData(with: localCachedAppData()) {
            return
        } else if loadAppData(with: bundledAppData()) {
            return
        }
    }
    private func parse(data: Data) -> [BasicItem]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if json is NSDictionary {
                let jsonDictionary = json as! NSDictionary
                let newData: [BasicItem]? = try jsonDictionary.value(for: "items")
                return newData
            }
        } catch {
            return nil
        }

        return nil
    }
    
    private func isValid(parsedData: [BasicItem]?) -> Bool {
        return parsedData?.count == 5
    }
    
    private func bundledAppData() -> Data? {
        return Bundle.bundledAppData()
    }
    
    private func localCachedAppData() -> Data? {
        return FileManager.localCachedAppData()
    }
    
    private func saveAndLoadIfValid(data: Data?) {
        if let data = data, loadAppData(with: data) {
            FileManager.saveToLocalAppDataFile(data: data)
            postNotificationNewData()
            return
        }
    }
    
    private func postNotificationNewData() {
        NotificationCenter.default.post(name: .didReceiveNewData, object: nil)
    }
    
    private func loadAppData(with data: Data?) -> Bool {
        if let data = data,
            let newAppData = parse(data: data),
            isValid(parsedData: newAppData) {
            appData = newAppData
            return true
        }
        
        return false
    }
    
    func update() {
        update(completion: nil)
    }

    func update(completion: (() -> Void)?) {
        let newAppDataRef = storage.reference(withPath: "appdata.json")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        newAppDataRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
            if let _ = error {
            } else {
                self?.saveAndLoadIfValid(data: data)
            }
            
            completion?()
        }
    }
}
