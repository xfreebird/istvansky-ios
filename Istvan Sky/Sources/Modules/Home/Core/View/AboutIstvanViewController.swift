//
//  AboutIstvanViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/28/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit

class AboutIstvanViewController: ItemDetailsViewController {
    weak var presenter: HomePresenter?
    
    override func allScrollViewSubviews() -> [UIView] {
        mediaView = imageHeaderView()
        textView = decriptionTextView()

        title = viewModel?.title

        return [mediaView, textView]
    }
}
