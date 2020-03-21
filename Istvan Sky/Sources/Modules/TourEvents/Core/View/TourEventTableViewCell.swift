//
//  TourEventTableViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit
import SnapKit

class TourEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    var addToCalendarButton: UIButton!
    var shareButton: UIButton!

    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var eventLogoImageView: UIImageView!
    @IBOutlet weak var eventDateShortDayLabel: UILabel!
    @IBOutlet weak var eventDateShortMonthLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    weak var presenter: TourEventsPresenter?

    override func awakeFromNib() {
        super.awakeFromNib()
        frameView.layer.borderColor = UIColor.lightGray.cgColor
        frameView.layer.borderWidth = 1.0
        frameView.layer.cornerRadius = 5.0
        frameView.layer.masksToBounds = true
        eventLogoImageView.makeRoundCorners()
        
        bookButton.configure(title: NSLocalizedString("Book", comment: ""), isHighlighted: true)
        bookButton.addTarget(self, action: #selector(bookButtonTap), for: .touchUpInside)

        moreButton.configure(title: NSLocalizedString("More...", comment: ""))
        moreButton.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
        moreButton.setTitleColor(.globalTintColor(), for: .normal)

        if UIDevice.current.userInterfaceIdiom == .pad {
            addToCalendarButton = UIButton()
            addToCalendarButton.configure(title: NSLocalizedString("Add to Calendar", comment: ""))
            addToCalendarButton.addTarget(self, action: #selector(addToCalendarButtonTap), for: .touchUpInside)
            addToCalendarButton.setTitleColor(.globalTintColor(), for: .normal)

            shareButton = UIButton()
            shareButton.configure(title: NSLocalizedString("Share", comment: ""))
            shareButton.addTarget(self, action: #selector(shareButtonTap), for: .touchUpInside)
            shareButton.setTitleColor(.globalTintColor(), for: .normal)

            imageHeightConstraint.constant = 300
            moreButton.isHidden = true
            buttonsStackView.addArrangedSubview(addToCalendarButton)
            buttonsStackView.addArrangedSubview(shareButton)
        } else {
            imageHeightConstraint.constant = 190
        }
        
        layoutSubviews()
    }
    
    func updateView(viewModel: FLViewModel) {
        eventTitleLabel.text = viewModel.title
        eventDateShortDayLabel.text = viewModel.eventDay
        eventDateShortMonthLabel.text = viewModel.eventMonth
        
        eventLogoImageView.updateImage(imageName: viewModel.imageName,
                                       imageURL: viewModel.imageUrl)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let color = UIColor.globalTintColor()
        bookButton.backgroundColor = color
    }
    
    @objc func bookButtonTap(sender : UIButton) {
        presenter?.bookItem(index: tag)
    }

    @objc func moreButtonTap(sender : UIButton) {
        presenter?.moreItems(index: tag)
    }
    
    @objc func shareButtonTap(sender : UIButton) {
        presenter?.shareItem(index: tag)
    }

    @objc func addToCalendarButtonTap(sender : UIButton) {
        presenter?.addToCalendar(index: tag)
    }

}
