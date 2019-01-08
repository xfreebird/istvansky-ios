//
//  BasicItem.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation
import Marshal


struct BasicItem: Unmarshaling {
    let imageName: LocalizedValue?
    let imageUrl: LocalizedValue?
    let youtubeVideoId: LocalizedValue?
    let title: LocalizedValue?
    let content: LocalizedValue?
    let webUrl: LocalizedValue?
    let actionTitle: LocalizedValue?
    let type: BasicItemType
    let date: Date?
    let endDate: Date?
    let timeZone: TimeZone?
    let hideItemsPreview: Bool
    let audioUrl: LocalizedValue?
    let items: [BasicItem]?
    
    init(object: MarshaledObject) throws {
        imageName = try object.value(for: "imageName")
        imageUrl = try object.value(for: "imageUrl")
        youtubeVideoId = try object.value(for: "youtubeVideoId")
        title = try object.value(for: "title")
        content = try object.value(for: "content")
        webUrl = try object.value(for: "webUrl")
        actionTitle = try object.value(for: "actionTitle")
        type = try object.value(for: "type")
        date = try object.value(for: "date")
        endDate = try object.value(for: "endDate")
        timeZone = try object.value(for: "timeZone")
        items = try object.value(for: "items")
        audioUrl = try object.value(for: "audioUrl")
        
        let boolValue: Bool? = try object.value(for: "hideItemsPreview")
        hideItemsPreview = boolValue ?? false
    }
}
