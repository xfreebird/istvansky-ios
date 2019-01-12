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
    func showConfirmClearCache(completion: @escaping ((Bool) -> Void))
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
    
    func showConfirmClearCache(completion: @escaping ((Bool) -> Void)) {
        let removeCacheAction = UIAlertAction(title: NSLocalizedString("Remove cache", comment: ""),
                                                style: .destructive) { (action) in
                                                    completion(true)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                         style: .cancel)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(removeCacheAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
