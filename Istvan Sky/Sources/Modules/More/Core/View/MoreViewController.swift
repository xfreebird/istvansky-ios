//
//  MoreViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol MoreView: class {
    func viewDidLoad()
    func updateView(viewModel: FLViewModel)
}

class MoreViewController: UIViewController, MoreView {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MorePresenter!
    var tableViewDataSource: UITableViewDataSource!
    var tableViewDelegate: UITableViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func updateView(viewModel: FLViewModel) {
        title = viewModel.title
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
    }
}
