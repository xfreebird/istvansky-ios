//
//  IstvanSkyPlayerViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/12/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SnapKit
import AVKit
import XCDYouTubeKit
import YoutubeKit

protocol IstvanSkyPlayer {
    var isAudioOnly: Bool { get set }
    func updateView(viewModel: IstvanSkyPlayerViewModel)
}

struct IstvanSkyPlayerViewModel {
    let url: URL?
    let youtubeVideoId: String?
    let thumbnailImagename: String?
    let thumbnailImageLink: String?
    let isAudioOnly: Bool
    let usePlayerWithSubtitles: Bool
    
    init(link: String?, youtubeVideoId: String?,
         thumbnailImagename: String?,
         thumbnailImageLink: String?,
         isAudioOnly: Bool,
         usePlayerWithSubtitles: Bool) {
        self.youtubeVideoId = youtubeVideoId
        self.thumbnailImageLink = thumbnailImageLink
        self.thumbnailImagename = thumbnailImagename
        self.isAudioOnly = isAudioOnly
        self.usePlayerWithSubtitles = usePlayerWithSubtitles
        
        if let link = link, let linkUrl = URL(string: link) {
            url = linkUrl
        } else {
            url = nil
        }
    }
}

class IstvanSkyPlayerViewController: UIViewController, IstvanSkyPlayer {
    enum IstvanSkyPlayerState {
        case notInitialized
        case preparingPlayer
        case readyToPlay
        case preparingToStream
        case streaming
        case withoutVideo
    }

    var imageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView?
    var playButton: UIButton?
    
    var avPlayer: AVPlayer?
    var avPlayerController: AVPlayerViewController? = AVPlayerViewController()
    
    var youtubePlayerWithSubtitles: YTSwiftyPlayer?
    
    var observer: Any?
    
    let buttonHeight: CGFloat = 40
    
    var state: IstvanSkyPlayerState = .notInitialized {
        didSet {
            updatePlayerViewStateChange()
        }
    }

    var url: URL?
    var youtubeVideoId: String?
    var thumbnailImagename: String?
    var thumbnailImageLink: String?
    var isAudioOnly: Bool = false
    var usePlayerWithSubtitles: Bool = false
    var withoutVideo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStreamingView()
    }
    
    @objc func playButtonAction() {
        guard state == .notInitialized else {
            return
        }
        
        loadPlayer()
    }
    
    func updateView(viewModel: IstvanSkyPlayerViewModel) {
        url = viewModel.url
        youtubeVideoId = viewModel.youtubeVideoId
        thumbnailImagename = viewModel.thumbnailImagename
        thumbnailImageLink = viewModel.thumbnailImageLink
        isAudioOnly = viewModel.isAudioOnly
        usePlayerWithSubtitles = viewModel.usePlayerWithSubtitles
        
        imageView.updateImage(imageName: thumbnailImagename,
                              imageURL: thumbnailImageLink)
        avPlayer?.pause()
        
        if url == nil && youtubeVideoId == nil {
            state = .withoutVideo
        } else {
            state = .notInitialized
        }
    }
    
    deinit {
        if let observer = observer {
            avPlayer?.removeTimeObserver(observer)
            avPlayer?.pause()
            avPlayer = nil
            self.observer = nil
        }

        avPlayerController?.player = nil
        avPlayerController?.willMove(toParent: nil)
        avPlayerController?.view.removeFromSuperview()
        avPlayerController?.removeFromParent()
        avPlayerController = nil
    }
    
    func imageHeaderView() -> UIImageView {
        let customImageView = UIImageView(image: nil)
        customImageView.makeRoundCorners()
        customImageView.translatesAutoresizingMaskIntoConstraints = true
        
        customImageView.updateImage(imageName: thumbnailImagename, imageURL: thumbnailImageLink)
        customImageView.contentMode = .scaleAspectFill
        customImageView.clipsToBounds = true
        customImageView.layer.borderWidth = 1.0
        customImageView.layer.borderColor = UIColor.lightGray.cgColor
        customImageView.isUserInteractionEnabled = true
        
        return customImageView
    }
    
    func addStreamingView() {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addImageHeader(container: containerView)
        addPlayButton(container: containerView)
        addActivityIndicator(container: containerView)
        addPlayerView(container: containerView)
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
        playButton?.setImage(UIImage(named: "play"), for: .normal)
        playButton?.imageView?.contentMode = .scaleAspectFit
        playButton?.titleLabel?.textColor = UIColor.red
        playButton?.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        playButton?.alpha = 0.6
        container.addSubview(playButton!)
        playButton?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
        avPlayer?.automaticallyWaitsToMinimizeStalling = false
        
        if let avPlayerController = avPlayerController {
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
        }
        
        addPlayerObserver()
    }
    
    func addiFramePlayer(container: UIView) {
        if let youtubeVideoId = youtubeVideoId {
            let youtubePlayerWithSubtitles = YTSwiftyPlayer(frame: CGRect.zero, playerVars: [.videoID(youtubeVideoId), .playsInline(false)])
            self.youtubePlayerWithSubtitles = youtubePlayerWithSubtitles
            container.addSubview(youtubePlayerWithSubtitles)
            youtubePlayerWithSubtitles.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            youtubePlayerWithSubtitles.alpha = 0
            youtubePlayerWithSubtitles.delegate = self
            youtubePlayerWithSubtitles.autoplay = true
            youtubePlayerWithSubtitles.loadPlayer()
        }
        
        return
    }
    
    func loadPlayer() {
        if usePlayerWithSubtitles {
            addiFramePlayer(container: view)
            state = .preparingToStream
            return
        }

        state = .preparingPlayer
        
        if isAudioOnly, let url = url {
            let item = playerItem(for: url)
            item.delegate = self
            avPlayer?.replaceCurrentItem(with: item)
            state = .preparingToStream
            
        } else if let youtubeVideoId = youtubeVideoId {
            retrieveYoutubeVideoUrl(youtubeVideoId: youtubeVideoId) { [weak self] (youtubeVideoUrl) in
                if let youtubeVideoUrl = youtubeVideoUrl {
                    self?.avPlayer?.replaceCurrentItem(with: AVPlayerItem(url: youtubeVideoUrl))
                    self?.state = .preparingToStream
                }
            }
        }
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

extension IstvanSkyPlayerViewController {
    func updatePlayerViewStateChange() {
        switch state {
        case .preparingPlayer:
            showAVPlayerSetupState()
        case .readyToPlay:
            showReadyToPlayState()
        case .preparingToStream:
            showPreparingToStreamState()
        case .streaming:
            showStreamingState()
        case .withoutVideo:
            showImageOnly()
        case .notInitialized:
            break
        }
    }
    
    func showImageOnly() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = true
        avPlayerController?.view.alpha = 0
    }

    func showAVPlayerSetupState() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = false
        avPlayerController?.view.alpha = 0
        activityIndicator?.startAnimating()
    }
    
    func showReadyToPlayState() {
        playButton?.isHidden = false
        activityIndicator?.isHidden = true
        avPlayerController?.view.alpha = 0
        activityIndicator?.stopAnimating()
    }
    
    func showPreparingToStreamState() {
        playButton?.isHidden = true
        activityIndicator?.isHidden = false
        avPlayerController?.view.alpha = 0
        activityIndicator?.startAnimating()
        avPlayer?.play()
    }
    
    func showStreamingState() {
        activityIndicator?.stopAnimating()
        playButton?.isHidden = true
        activityIndicator?.isHidden = true
        avPlayerController?.view.alpha = 1
        
        if isAudioOnly {
            let thumbnail = imageHeaderView()
            avPlayerController?.contentOverlayView?.addSubview(thumbnail)
            thumbnail.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
    }
}

extension IstvanSkyPlayerViewController: YTSwiftyPlayerDelegate {
    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        player.alpha = 1
    }
}
extension IstvanSkyPlayerViewController: CachingPlayerItemDelegate {
    func playerItem(for url: URL) -> CachingPlayerItem {
        if let urlLink = url.absoluteString.hashed(.md5),
            let data = FileManager.localCachedAppData(fileNameAndExtension: urlLink) {
            return CachingPlayerItem(data: data, mimeType: "audio/mpeg", fileExtension: "mp3")
        }
        return CachingPlayerItem(url: url)
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        if let urlLink = playerItem.url.absoluteString.hashed(.md5) {
            FileManager.saveToLocalAppDataFile(data: data, fileNameAndExtension: urlLink)
        }
    }
}

extension IstvanSkyPlayerViewController {
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
            if state != .streaming {
                state = .streaming
            }
        }
    }
}
