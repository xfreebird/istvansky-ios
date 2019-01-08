//
//  BaseViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import SafariServices

class BaseViewController: UIViewController, SFSafariViewControllerDelegate {
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillResignActive),
                                               name: UIApplication.willResignActiveNotification, object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    @objc private func applicationWillResignActive() {
        refreshControl.endRefreshing()
    }

    @objc func reloadData() {
        
    }

    func openWebPage(url: URL) {
        let safariVC = ExtendedSFSafariViewController(url: url)
        if #available(iOS 11.0, *) {
            safariVC.dismissButtonStyle = .close
        }
        
        safariVC.delegate = self
        navigationController?.pushViewController(safariVC, animated: true)
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addShareButton() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action,
                                          target: self,
                                          action: #selector(showShareMenu))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func showShareMenu() {
        
    }

    func presentActivityController(message: String, url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.assignToContact,
                                                        .openInIBooks,
                                                        .print,
                                                        .saveToCameraRoll,
                                                        .postToWeibo,
                                                        .postToFlickr,
                                                        .postToVimeo
        ]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }

        present(activityViewController, animated: true)
    }

    func flowerTableViewBackground() -> UIView {
        let imageView = UIImageView(image: UIImage(named: "flower"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.03
        return imageView
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
