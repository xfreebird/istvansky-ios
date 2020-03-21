//
//  HealingMusicViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 06/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol HealingMusicView: class {
    func updateView(viewModel: [FLViewModel])
}

class HealingMusicViewController: BaseViewController, HealingMusicView {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HealingMusicPresenter!

    var tableViewDataSource: FLTableViewDataSource!
    var tableViewDelegate: FLTableViewDelegate!
    var collectionViewDataSource: FLCollectionViewDataSource!
    var collectionViewDelegate: FLCollectionViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedCellType = String(describing: FLCollectionViewTableViewCell.self)
        let homeCellType = String(describing: FLTableViewCell.self)
        let mediaCellType = String(describing: FLMediaTableViewCell.self)
        tableView.register(UINib(nibName: feedCellType, bundle: nil), forCellReuseIdentifier: feedCellType)
        tableView.register(UINib(nibName: homeCellType, bundle: nil), forCellReuseIdentifier: homeCellType)
        tableView.register(UINib(nibName: mediaCellType, bundle: nil), forCellReuseIdentifier: mediaCellType)

        addShareButton()
        
        presenter.viewDidLoad()
    }
    
    func updateView(viewModel: [FLViewModel]) {
        collectionViewDataSource = FLCollectionViewDataSourceImp(presenter: presenter)
        collectionViewDelegate = FLCollectionViewDelegateImp(presenter: presenter)
        tableViewDataSource = FLTableViewDataSourceImp(presenter: presenter,
                                                       collectionViewDataSource: collectionViewDataSource,
                                                       collectionViewDelegate: collectionViewDelegate)
        tableViewDelegate = FLTableViewDelegateImp(presenter: presenter)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.reloadData()
    }
    
    override func showShareMenu() {
        if let url = presenter.shareUrl() {
            presentActivityController(message: NSLocalizedString("Istvan Sky Music", comment: ""), url: url)
        }
    }
}
