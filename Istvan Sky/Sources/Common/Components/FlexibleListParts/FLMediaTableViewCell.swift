//
//  FLMediaTableViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//
import UIKit

class FLMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var appleMusicButton: UIButton!
    @IBOutlet weak var listenToLabel: UILabel!
    
    weak var presenter: FRProxyDataPresenter?
    var buttonTypeMapping: [UIButton : FLViewModelType] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [instagramButton, facebookButton,
         youtubeButton, appleMusicButton].forEach { (button) in
            button.imageView!.contentMode = .scaleAspectFit
        }
        
        buttonTypeMapping = [
            instagramButton : .instagram,
            facebookButton : .facebook,
            youtubeButton : .youtube,
            appleMusicButton : .appleMusic
        ]
    }
    
    func updateView(viewModel: FLViewModel) {
        listenToLabel.text = viewModel.description
        
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        let button = sender as! UIButton
        if let buttonType = buttonTypeMapping[button] {
            presenter?.processAction(for: buttonType)
        }
    }
}
