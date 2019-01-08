//
//  AshramBlogItemTableViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit

class AshramBlogItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!

    func updateView(viewModel: FLViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.blogFormattedDate
        descriptionLabel.text = viewModel.description
        readMoreLabel.text = viewModel.readMore
    }
}
