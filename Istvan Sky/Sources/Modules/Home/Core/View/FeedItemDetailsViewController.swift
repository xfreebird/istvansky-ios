//
//  FeedItemDetailsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class FeedItemDetailsViewController: ItemDetailsViewController {
    var actionButton: UIButton!
    weak var presenter: HomePresenter?
    
    override func allScrollViewSubviews() -> [UIView] {
        mediaView = contentStreamingView()
        textView = decriptionTextView()

        actionButton = UIButton()
        actionButton.configure(title: viewModel?.actionTitle)
        actionButton.layer.borderColor = UIColor.lightGray.cgColor
        actionButton.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
        
        title = viewModel?.title
        setupTapGesture()

        return [mediaView, textView, actionButton]
    }
    
    func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionButtonTap))
        if viewModel?.youtubeVideoId == nil {
            mediaView.addGestureRecognizer(tap)
            mediaView.isUserInteractionEnabled = true
        }
    }
    
    @objc func actionButtonTap() {
        if let viewModel = viewModel {
            presenter?.processFeedItemAction(type: viewModel.type, webUrl: viewModel.webUrl)            
        }
    }
}
