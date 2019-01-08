//
//  FLBasicItemCollectionViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit
import SDWebImage

class FLBasicItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    func updateView(viewModel: FLViewModel) {
        imageView.updateImage(imageName: viewModel.imageName,
                              imageURL: viewModel.imageUrl)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
    }
}
