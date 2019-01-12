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

    override func isAudioOnly() -> Bool {
        return true
    }

    override func allScrollViewSubviews() -> [UIView] {
        mediaView = contentStreamingView()
        textView = decriptionTextView()

        title = viewModel?.title
        return [mediaView, titleHeader(), textView]
    }
}
