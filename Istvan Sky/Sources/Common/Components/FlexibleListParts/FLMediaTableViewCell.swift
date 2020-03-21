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
    @IBOutlet weak var itunesButton: UIButton!
    @IBOutlet weak var spotifyButton: UIButton!
    @IBOutlet weak var deezerButton: UIButton!
    @IBOutlet weak var bandcampButton: UIButton!
    @IBOutlet weak var amazonButton: UIButton!
    @IBOutlet weak var tidalButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var followIstvanSkyLabel: UILabel!
    
    weak var presenter: FRProxyDataPresenter?
    var buttonTypeMapping: [UIButton : FLViewModelType] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [instagramButton, facebookButton,
         youtubeButton, appleMusicButton,
         itunesButton, spotifyButton,
         deezerButton, bandcampButton,
         amazonButton, googleButton,
         tidalButton].forEach { (button) in
            button.imageView!.contentMode = .scaleAspectFit
        }
        
        buttonTypeMapping = [
            instagramButton : .instagram,
            facebookButton : .facebook,
            youtubeButton : .youtube,
            appleMusicButton : .appleMusic,
            itunesButton : .appleiTunes,
            spotifyButton : .spotify,
            deezerButton : .deezer,
            googleButton : .googleMusic,
            amazonButton : .amazon
        ]
    }
    
    func updateColors(to traitCollection: UITraitCollection) {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                listenToLabel.textColor = .lightGray
                followIstvanSkyLabel.textColor = .lightGray
                return
            }
        }
        
        listenToLabel.textColor = .darkGray
        followIstvanSkyLabel.textColor = .darkGray

    }

    func updateView(viewModel: FLViewModel) {
        listenToLabel.text = viewModel.description
        updateColors(to: traitCollection)
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        let button = sender as! UIButton
        if let buttonType = buttonTypeMapping[button] {
            presenter?.processAction(for: buttonType)
        }
    }
}
