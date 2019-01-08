//
//  UIImageViewUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/3/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func updateImage(imageName: String?, imageURL: String?) {
        let placeholderImage = UIImage(named: "placeholder")
        
        image = placeholderImage
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            sd_setImage(with: url,
                                  placeholderImage: placeholderImage)
        } else if let imageName = imageName,
            let localImage = UIImage(named: imageName) {
            image = localImage
        }
    }
}
