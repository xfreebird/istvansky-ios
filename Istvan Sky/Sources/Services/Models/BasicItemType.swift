//
//  BasicItemType.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

enum BasicItemType: String {
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
    case appleMusic = "applemusic"
    case appleiTunes = "appleitunes"
    case deezer
    case googleMusic = "googlemusic"
    case tidal
    case amazon
    case youtube
    case facebook
    case instagram
    case privacyPolicy = "privacypolicy"
    case thirdParty = "thirdparty"
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
