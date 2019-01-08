//
//  FileManagerUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/8/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

fileprivate let localAppDataFileName = "appdata.json"

extension FileManager {
    
    static func localCachedAppData(fileNameAndExtension: String = localAppDataFileName) -> Data? {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: false)
            let fileURL = documentDirectory.appendingPathComponent(fileNameAndExtension)
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
        }

        return nil
    }
    
    static func saveToLocalAppDataFile(data: Data, fileNameAndExtension: String = localAppDataFileName) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: true)
            let fileURL = documentDirectory.appendingPathComponent(fileNameAndExtension)
            try data.write(to: fileURL)
        } catch {
        }
    }

    
    

    
    
}
