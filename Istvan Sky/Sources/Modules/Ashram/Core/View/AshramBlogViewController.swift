//
//  AshramBlogViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit

protocol AshramView: class {
    func updateView(viewModel: [FLViewModel])
}

class AshramBlogViewController: UIViewController,  AshramView {
    var presenter: AshramPresenter!
    var tableViewDataSource: AshramBlogViewDataSource!
    var tableViewDelegate: AshramBlogViewDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableViewHeaderView() -> UIView {
        let headerView = AshramBlogHeaderView(frame: CGRect(x: 0, y: 0,
                                                            width: 320, height: 320))
        headerView.imageView?.image = UIImage(named: presenter.headerImage())
        return headerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemCellType = String(describing: AshramBlogItemTableViewCell.self)
        
        tableView.register(UINib(nibName: itemCellType, bundle: nil), forCellReuseIdentifier: itemCellType)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        presenter.viewDidLoad()
        navigationItem.title = presenter.title()
        tableView.tableHeaderView = tableViewHeaderView()
    }
    
    func updateView(viewModel: [FLViewModel]) {
        tableView.reloadData()
    }
}
