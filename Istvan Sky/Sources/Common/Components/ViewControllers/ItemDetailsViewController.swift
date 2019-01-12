//
//  ItemDetailsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/1/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices

class ItemDetailsViewController: BaseViewController {
    var viewModel: FLViewModel?
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var textView: UITextView!

    var mediaView: UIView!
    let marginOffset: CGFloat = 9
    let buttonHeight: CGFloat = 40

    func allScrollViewSubviews() -> [UIView] {
        return []
    }
    
    func updateView(viewModel: FLViewModel) {
        self.viewModel = viewModel
        layoutComponents()
    }

    func isAudioOnly() -> Bool {
        return false
    }
    
    func layoutComponents() {
        let allSubviews = allScrollViewSubviews()
        if let scrollView = scrollView?.superview {
            scrollView.subviews.forEach { subview in
                subview.removeFromSuperview()
            }
            scrollView.removeFromSuperview()
        }

        view.backgroundColor = UIColor.white
        scrollView = UIScrollView(frame: CGRect.zero)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view)
                make.bottom.equalTo(view)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            } else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        var previousSubview: UIView = scrollView
        for subView in allSubviews {
            scrollView.addSubview(subView)
            subView.snp.makeConstraints { (make) in
                if subView == allSubviews.first {
                    make.top.equalToSuperview().offset(marginOffset)
                } else {
                    make.top.equalTo(previousSubview.snp.bottom).offset(marginOffset)
                }
                
                make.leading.equalTo(scrollView).offset(marginOffset)
                make.trailing.equalTo(scrollView).offset(marginOffset)
                if #available(iOS 11.0, *) {
                    make.width.equalTo(view.safeAreaLayoutGuide.snp.width).offset(-2 * marginOffset)
                } else {
                    make.width.equalTo(view).offset(-2 * marginOffset)
                }
                
                if subView is UIButton {
                    make.height.equalTo(buttonHeight)
                }
                
                if subView == mediaView {
                    make.height.equalTo(subView.snp.width).multipliedBy(9.0/16.0)
                }
                
                if subView == allSubviews.last {
                    make.bottom.equalToSuperview().offset(-marginOffset)
                }
                
                previousSubview = subView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShareButton()
    }
    
    deinit {
    }

    override func showShareMenu() {
        if let title = viewModel?.title,
            let webUrl = viewModel?.webUrl,
            let url = URL(string: webUrl) {
            presentActivityController(message: title, url: url)
        }
    }

    func imageHeaderView() -> UIImageView {
        let customImageView = UIImageView(image: nil)
        customImageView.makeRoundCorners()
        customImageView.translatesAutoresizingMaskIntoConstraints = true
        
        customImageView.updateImage(imageName: viewModel?.imageName, imageURL: viewModel?.imageUrl)
        customImageView.contentMode = .scaleAspectFill
        customImageView.clipsToBounds = true
        customImageView.layer.borderWidth = 1.0
        customImageView.layer.borderColor = UIColor.lightGray.cgColor
        customImageView.isUserInteractionEnabled = true
        
        return customImageView
    }

    func playerViewModel() -> IstvanSkyPlayerViewModel {
        let link: String? = isAudioOnly() ? viewModel?.audioUrl : nil
        let youtubeVideoId = viewModel?.youtubeVideoId
        let thumbnailImagename = viewModel?.imageName
        let thumbnailImageLink = viewModel?.imageUrl
        let audioOnly = isAudioOnly()
        let usePlayerWithSubtitles: Bool = viewModel?.playWithSubtitles ?? false
        

        let playerViewModel = IstvanSkyPlayerViewModel(link: link,
                                                       youtubeVideoId: youtubeVideoId,
                                                       thumbnailImagename: thumbnailImagename,
                                                       thumbnailImageLink: thumbnailImageLink,
                                                       isAudioOnly: audioOnly,
                                                       usePlayerWithSubtitles: usePlayerWithSubtitles)
        return playerViewModel
    }
    
    func contentStreamingView() -> UIView {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let playerViewController = IstvanSkyPlayerViewController()
        addChild(playerViewController)
        containerView.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        playerViewController.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        playerViewController.updateView(viewModel: playerViewModel())

        return containerView
    }
    
    func titleHeader() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = viewModel?.title
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }

    func decriptionTextView() -> UITextView {
        let customTextView = UITextView(frame: CGRect.zero)
        customTextView.translatesAutoresizingMaskIntoConstraints = true
        customTextView.sizeToFit()
        customTextView.isScrollEnabled = false
        customTextView.font = UIFont.systemFont(ofSize: 18)
        customTextView.text = viewModel?.description
        customTextView.dataDetectorTypes = .link
        customTextView.isEditable = false
        customTextView.delegate = self
        customTextView.textContainer.lineFragmentPadding = 0
        customTextView.textContainerInset = .zero
        return customTextView
    }
}

extension ItemDetailsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        openWebPage(url: URL)
        return false
    }
    
}
