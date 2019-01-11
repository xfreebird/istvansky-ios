//
//  FLTableViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit

class FLTableViewCell: UITableViewCell {
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageHeaderView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        readMoreLabel.textColor = UIColor.lightGray
        imageHeaderView.makeRoundCorners()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            imageHeightConstraint.constant = 280
            descriptionLabel.numberOfLines = 8
        } else {
            descriptionLabel.numberOfLines = 4
        }
    }
    
    func updateView(viewModel: FLViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        readMoreLabel.text = viewModel.readMore
        imageHeaderView.updateImage(imageName: viewModel.imageName,
                                    imageURL: viewModel.imageUrl)
    }
}
