//
//  FLViewModel.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

enum FLViewModelType: String {
    case home
    case tour
    case about
    case web
    case feed
    case ashram
    case blogpost
    case booking
    case music
    case meditation
    case meditations
    case event
    case donate
    case support
    case contact
    case more
    case bandcamp
    case spotify
    case appleMusic
    case appleiTunes
    case deezer
    case googleMusic
    case tidal
    case amazon
    case youtube
    case facebook
    case instagram
    case privacyPolicy
    case thirdParty
    case version
    case tandc
    case unknown
    
    init(rawValue: String) {
        switch rawValue {
        case "home": self = .home
        case "tour": self = .tour
        case "about": self = .about
        case "web": self = .web
        case "feed": self = .feed
        case "ashram": self = .ashram
        case "blogpost": self = .blogpost
        case "booking": self = .booking
        case "music": self = .music
        case "meditation": self = .meditation
        case "meditations": self = .meditations
        case "event": self = .event
        case "donate": self = .donate
        case "support": self = .support
        case "contact": self = .contact
        case "more": self = .more
        case "bandcamp": self = .bandcamp
        case "spotify": self = .spotify
        case "applemusic": self = .appleMusic
        case "appleitunes": self = .appleiTunes
        case "deezer": self = .deezer
        case "googlemusic": self = .googleMusic
        case "tidal": self = .tidal
        case "amazon": self = .amazon
        case "youtube": self = .youtube
        case "facebook": self = .facebook
        case "instagram": self = .instagram
        case "privacypolicy": self = .privacyPolicy
        case "thirdparty": self = .thirdParty
        case "version": self = .version
        case "tandc": self = .tandc
        default: self = .unknown
        }
    }
}

struct FLViewModel {
    let title: String?
    let description: String?
    let imageName: String?
    let imageUrl: String?
    let readMore: String?
    let youtubeVideoId: String?
    let webUrl: String?
    let actionTitle: String?
    let eventDate: Date?
    let eventEndDate: Date?
    let eventTimeZone: TimeZone?
    let eventMonth: String?
    let eventDay: String?
    let blogFormattedDate: String?
    let type: FLViewModelType
    let hideItemsPreview: Bool
    let audioUrl: String?
    let items: [FLViewModel]?
    
    init(title: String?,
         description: String?,
         imageName: String?,
         imageUrl: String?,
         readMore: String?,
         youtubeVideoId: String?,
         webUrl: String?,
         actionTitle: String?,
         eventDate: Date?,
         eventEndDate: Date?,
         eventTimeZone: TimeZone?,
         eventMonth: String?,
         eventDay: String?,
         blogFormattedDate: String?,
         type: FLViewModelType,
         hideItemsPreview: Bool,
         audioUrl: String?,
         items: [FLViewModel]?) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.readMore = readMore
        self.youtubeVideoId = youtubeVideoId
        self.webUrl = webUrl
        self.actionTitle = actionTitle
        self.eventDate = eventDate
        self.eventTimeZone = eventTimeZone
        self.eventEndDate = eventEndDate
        self.eventDay = eventDay
        self.eventMonth = eventMonth
        self.blogFormattedDate = blogFormattedDate
        self.type = type
        self.hideItemsPreview = hideItemsPreview
        self.audioUrl = audioUrl
        self.items = items
    }
    
    init(title: String?,
         type: FLViewModelType) {
        self.title = title
        self.type = type

        description = nil
        imageName = nil
        imageUrl = nil
        readMore = nil
        youtubeVideoId = nil
        webUrl = nil
        actionTitle = nil
        eventDate = nil
        eventEndDate = nil
        eventTimeZone = nil
        eventMonth = nil
        eventDay = nil
        blogFormattedDate = nil
        hideItemsPreview = false
        audioUrl = nil
        items = nil
    }

    init() {
        title = nil
        description = nil
        imageName = nil
        imageUrl = nil
        readMore = nil
        youtubeVideoId = nil
        webUrl = nil
        actionTitle = nil
        eventDate = nil
        eventEndDate = nil
        eventTimeZone = nil
        eventMonth = nil
        eventDay = nil
        blogFormattedDate = nil
        type = .unknown
        hideItemsPreview = false
        audioUrl = nil
        items = nil
    }

}
