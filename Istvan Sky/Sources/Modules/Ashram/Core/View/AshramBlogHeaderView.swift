//
//  AshramBlogHeaderView.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/5/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SnapKit

class AshramBlogHeaderView: UIView {
    var imageView: UIImageView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        translatesAutoresizingMaskIntoConstraints = true
        backgroundColor = .groupTableViewBackground
        
        imageView = UIImageView(frame: CGRect.zero)

        if let imageView = imageView {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true

            addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(9)
                make.bottom.equalToSuperview().offset(-9)
                make.leading.equalToSuperview().offset(9)
                make.trailing.equalToSuperview().offset(-9)
            }
        }
    }

}
