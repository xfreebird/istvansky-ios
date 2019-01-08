//
//  MoreTableViewDelegate.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/7/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class MoreTableViewDelegate: NSObject, UITableViewDelegate {
    weak var presenter: MorePresenter!

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.itemSelected(index: indexPath.row)
    }
    
}
