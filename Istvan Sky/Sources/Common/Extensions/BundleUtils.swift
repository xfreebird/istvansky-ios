//
//  BundleUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/8/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

fileprivate let bundledAppDataFileName = "appdata.json"
fileprivate let bundledTAndCFileName = "terms_and_conditions.html"
fileprivate let bundledPrivacyPolicyFileName = "privacy_policy.html"
fileprivate let bundledAknowledgementsFileName = "aknowledgements.html"
fileprivate let bundledAppDataSubdirectory = "appdata"
fileprivate let defaultBrowseAddress = "about:blank"

extension Bundle {
    static private func fileParts(fileNameAndExtension: String) -> (fileName: String, fileExtension: String)? {
        let components = fileNameAndExtension.components(separatedBy: ".")
        if components.count > 1 {
            let fileNameComponent = components[0]
            let fileExtensionComponent = components[1]
            return (fileName: fileNameComponent, fileExtension: fileExtensionComponent)
        }
        
        return nil
    }
    
    static func infoPlistValue(for key: String) -> String? {
        if let dictionary = Bundle.main.infoDictionary {
            return dictionary[key] as? String
        }
        return nil
    }
    
    static func appVersion() -> String {
        return infoPlistValue(for: "CFBundleShortVersionString") ?? "1.0"
    }
    
    static func appBuildNumber() -> String {
        return infoPlistValue(for: "CFBundleVersion") ?? "1"
    }

    static func bundledAppData(fileNameAndExtension: String = bundledAppDataFileName,
                               subdirectory: String = bundledAppDataSubdirectory) -> Data? {
        if let url = bundledFileUrl(fileNameAndExtension: fileNameAndExtension,
                                    subdirectory: subdirectory) {
            do {
                return try Data(contentsOf: url)
            } catch {
            }
        }
        
        return nil
    }
    
    static func bundledTAndCFileURL(language: String = NSLocale.appLanguage()) -> URL {
        if let fileURL = Bundle.bundledFileUrl(fileNameAndExtension: bundledTAndCFileName,
                                               subdirectory: bundledAppDataSubdirectory,
                                               language: language) {
            return fileURL
        }
        return URL(string: defaultBrowseAddress)!
    }
    
    static func bundledPrivacyFileURL(language: String = NSLocale.appLanguage()) -> URL {
        if let fileURL = Bundle.bundledFileUrl(fileNameAndExtension: bundledPrivacyPolicyFileName,
                                               subdirectory: bundledAppDataSubdirectory,
                                               language: language) {
            return fileURL
        }
        return URL(string: defaultBrowseAddress)!
    }
    
    static func bundledThirdPartyFileURL(language: String = NSLocale.appLanguage()) -> URL {
        if let fileURL = Bundle.bundledFileUrl(fileNameAndExtension: bundledAknowledgementsFileName,
                                               subdirectory: bundledAppDataSubdirectory,
                                               language: language) {
            return fileURL
        }
        return URL(string: defaultBrowseAddress)!
    }


    static func bundledFileUrl(fileNameAndExtension: String,
                               subdirectory: String?,
                               language: String? = nil) -> URL? {
        guard let fileComponents = fileParts(fileNameAndExtension: fileNameAndExtension) else  {
            return nil
        }
        var url: URL? = nil
        let fileName = fileComponents.fileName
        let fileExtension = fileComponents.fileExtension

        if let subdirectory = subdirectory {
            var localizedSubdirectory = subdirectory
            if let language = language {
                localizedSubdirectory += "/\(language)"
            }
            url = Bundle.main.url(forResource: fileName, withExtension: fileExtension,
                                  subdirectory: localizedSubdirectory)
        } else {
            url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        }

        return url
    }
}
