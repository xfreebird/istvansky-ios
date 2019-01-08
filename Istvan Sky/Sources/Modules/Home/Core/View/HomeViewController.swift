//
//  HomeViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func updateView(viewModel: [FLViewModel])
}

class HomeViewController: BaseViewController, HomeView, UITableViewDelegate {
    var presenter: HomePresenter!
    var tableViewDataSource: FLTableViewDataSource!
    var tableViewDelegate: FLTableViewDelegate!
    var collectionViewDataSource: FLCollectionViewDataSource!
    var collectionViewDelegate: FLCollectionViewDelegate!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedCellType = String(describing: FLCollectionViewTableViewCell.self)
        let homeCellType = String(describing: FLTableViewCell.self)
        
        tableView.register(UINib(nibName: feedCellType, bundle: nil), forCellReuseIdentifier: feedCellType)
        tableView.register(UINib(nibName: homeCellType, bundle: nil), forCellReuseIdentifier: homeCellType)
        
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        tableView.refreshControl = refreshControl
        addShareButton()
        
        presenter.viewDidLoad()
    }
    
    override func reloadData() {
        presenter.reloadData()
    }
    
    func updateView(viewModel: [FLViewModel]) {
        refreshControl.endRefreshing()

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
            presentActivityController(message: "Istvan Sky", url: url)
        }
    }
}
