//
//  BasicItemUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/3/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

extension BasicItem {
    func convert() -> FLViewModel {
        let vmTitle = title?.localized
        let vmDescription = content?.localized
        let vmImageName = imageName?.localized
        let vmImageUrl = imageUrl?.localized
        let vmReadMore = NSLocalizedString("more...", comment: "")
        let vmYoutubeVideoId = youtubeVideoId?.localized
        let vmWebUrl = webUrl?.localized
        let vmActionTitle = actionTitle?.localized
        let vmType = FLViewModelType(rawValue: type.rawValue)
        var vmListItems: [FLViewModel]? = nil
        let vmHideItemsPreview = hideItemsPreview
        let vmPlayWithSubtitles = playWithSubtitles

        var vmEventDay: String? = nil
        var vmEventMonth: String? = nil
        var vmFormattedBlogDate: String? = nil
        let vmAudioUrl = audioUrl?.localized
        let eventTimeZone: TimeZone? = timeZone

        if let date = date {
            vmFormattedBlogDate = DateFormatter.blogPostDateFormatter().string(from: date)
            if let timeZone = timeZone {
                let formattedDate = DateFormatter.formattedEventDateComponents(from: date, timeZone: timeZone)
                vmEventMonth = formattedDate.month
                vmEventDay = formattedDate.day
            }
        }
        
        if items != nil {
            vmListItems = []
            items?.forEach({ item in
                let vmItem: FLViewModel = item.convert()
                vmListItems?.append(vmItem)
            })
        }

        return FLViewModel(title: vmTitle,
                                  description: vmDescription,
                                  imageName: vmImageName,
                                  imageUrl: vmImageUrl,
                                  readMore: vmReadMore,
                                  youtubeVideoId: vmYoutubeVideoId,
                                  webUrl: vmWebUrl,
                                  actionTitle: vmActionTitle,
                                  eventDate: date,
                                  eventEndDate: endDate,
                                  eventTimeZone: eventTimeZone,
                                  eventMonth: vmEventMonth,
                                  eventDay: vmEventDay,
                                  blogFormattedDate: vmFormattedBlogDate,
                                  type: vmType,
                                  hideItemsPreview: vmHideItemsPreview,
                                  playWithSubtitles: vmPlayWithSubtitles,
                                  audioUrl: vmAudioUrl,
                                  items: vmListItems)
    }
}
