//
//  MoreTableViewDataSource.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/7/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class MoreTableViewDataSource: NSObject, UITableViewDataSource {
    weak var presenter: MorePresenter!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.item(index: indexPath.row)
        let cell = UITableViewCell(frame: CGRect.zero)
        cell.textLabel?.text = viewModel.title
        
        if viewModel.type == .version {
            cell.selectionStyle = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}
