//
//  MeditationDetailsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import AVKit

class MeditationDetailsViewController: ItemDetailsViewController {
    weak var presenter: HomePresenter?
    
    override func allScrollViewSubviews() -> [UIView] {
        mediaView = contentStreamingView()
        textView = decriptionTextView()

        if let audioLink = viewModel?.audioUrl,
            let audioUrl = URL(string: audioLink) {
            addVideoStreamingView(url: audioUrl)
        }

        title = viewModel?.title
        return [mediaView, textView]
    }
}
