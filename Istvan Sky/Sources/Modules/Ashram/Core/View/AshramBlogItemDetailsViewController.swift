//
//  AshramBlogItemDetailsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/5/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class AshramBlogItemDetailsViewController: ItemDetailsViewController {
    
    override func allScrollViewSubviews() -> [UIView] {
        mediaView = contentStreamingView()
        textView = decriptionTextView()

        title = viewModel?.title
        var views: [UIView] = [textView]
        
        if let youtubeVideoId = viewModel?.youtubeVideoId {
            views.append(mediaView)
            retrieveYoutubeVideoUrl(youtubeVideoId: youtubeVideoId)
        }
        
        return views
    }
}
