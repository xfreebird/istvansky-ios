//
//  ItemDetailsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/1/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SnapKit
import AVKit
import SafariServices
import XCDYouTubeKit

class ItemDetailsViewController: BaseViewController {
    var viewModel: FLViewModel?
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var textView: UITextView!
    var activityIndicator: UIActivityIndicatorView?
    var playButton: UIButton?
    var avPlayer: AVPlayer?
    let avPlayerController = AVPlayerViewController()

    var observer: Any?

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
    
    func isAudioOnly() -> Bool {
        return false
    }

    func addPlayerObserver() {
        if let observer = observer {
            avPlayer?.removeTimeObserver(observer)
            self.observer = nil
        }
        
        let interval = CMTimeMake(value: 1, timescale: 10)
        observer = avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] (time) in
            self?.processPlayerState()
        })
    }
    
    func processPlayerState() {
        if avPlayer?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
            if activityIndicator?.isAnimating ?? false {
                showStreamingState()
            }
        }
    }
    
    deinit {
        if let observer = observer {
            avPlayer?.removeTimeObserver(observer)
            avPlayer = nil
            self.observer = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addShareButton()
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

    func contentStreamingView() -> UIView {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true
        containerView.translatesAutoresizingMaskIntoConstraints = false

        addImageHeader(container: containerView)
        addPlayButton(container: containerView)
        addActivityIndicator(container: containerView)
        addPlayerView(container: containerView)
        
        return containerView
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
        return customTextView
    }
    
    func addImageHeader(container: UIView) {
        imageView = imageHeaderView()
        container.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    func addPlayButton(container: UIView) {
        playButton = UIButton(type: .custom)
        playButton?.setTitle("Play", for: .normal)
        playButton?.titleLabel?.textColor = UIColor.red
        playButton?.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        
        container.addSubview(playButton!)
        playButton?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }

    func addActivityIndicator(container: UIView) {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        self.activityIndicator = activityIndicator
        container.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        activityIndicator.isHidden = true
    }

    func addPlayerView(container: UIView) {
        avPlayer = AVPlayer()
        addChild(avPlayerController)
        container.addSubview(avPlayerController.view)
        avPlayerController.didMove(toParent: self)
        avPlayerController.showsPlaybackControls = true
        avPlayerController.player = avPlayer
        avPlayerController.view.alpha = 0
        avPlayerController.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addPlayerObserver()
    }
    
    func initializePlayer() {
        showAVPlayerSetupState()
        
        if isAudioOnly(),
            let audioLink = viewModel?.audioUrl,
            let audioUrl = URL(string: audioLink) {
            avPlayer?.replaceCurrentItem(with: AVPlayerItem(url: audioUrl))
            showPreparingToStreamState()
            
        } else if let youtubeVideoId = viewModel?.youtubeVideoId {
            retrieveYoutubeVideoUrl(youtubeVideoId: youtubeVideoId) { [weak self] (youtubeVideoUrl) in
                if let youtubeVideoUrl = youtubeVideoUrl {
                    self?.avPlayer?.replaceCurrentItem(with: AVPlayerItem(url: youtubeVideoUrl))
                    self?.showPreparingToStreamState()
                }
            }
        }
    }
    
    @objc func playButtonAction() {
        guard let avPlayer = avPlayer else {
            return
        }
        
        if avPlayer.currentItem == nil {
            initializePlayer()
            return
        }
        
        if avPlayer.timeControlStatus == .playing {
            avPlayer.pause()
            showReadyToPlayState()
        } else {
            showPreparingToStreamState()
            avPlayer.play()
        }
    }
    
    func showAVPlayerSetupState() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = false
        avPlayerController.view.alpha = 0
        activityIndicator?.startAnimating()
    }
    
    func showAVPlayerReadyState() {
        activityIndicator?.stopAnimating()
        playButton?.isHidden = false
        activityIndicator?.isHidden = true
        avPlayerController.view.alpha = 0
    }
    
    func showReadyToPlayState() {
        playButton?.setTitle("Play", for: .normal)
        playButton?.isHidden = false
        activityIndicator?.isHidden = true
        avPlayerController.view.alpha = 0
        activityIndicator?.stopAnimating()
    }
    
    func showPreparingToStreamState() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = false
        avPlayerController.view.alpha = 0
        activityIndicator?.startAnimating()
        avPlayer?.play()
    }
    
    func showStreamingState() {
        activityIndicator?.stopAnimating()

        if isAudioOnly() {
            showAudioStreamingState()
        } else {
            showVideoStreamingState()
        }
    }

    func showVideoStreamingState() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = true
        avPlayerController.view.alpha = 1
    }
    
    func showAudioStreamingState() {
        playButton?.setTitle("Pause", for: .normal)
        playButton?.isHidden = false
        activityIndicator?.isHidden = true
        avPlayerController.view.alpha = 0
    }

    func retrieveYoutubeVideoUrl(youtubeVideoId: String, completion: @escaping ((URL?) -> Void)) {
        XCDYouTubeClient.default().getVideoWithIdentifier(youtubeVideoId) { (videoUrl, error) in
            let sd360VideoQuality = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
            let hd720VideoQuality = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
            let urls = videoUrl?.streamURLs
            let streamUrl = urls?[hd720VideoQuality] ?? urls?[sd360VideoQuality]
            completion(streamUrl)
        }
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
