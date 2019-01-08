//
//  HTMLFileViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/8/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class HTMLFileViewController: UIViewController {
    var webView: WKWebView = WKWebView()
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        loadUrl()
    }
    
    func loadUrl() {
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
