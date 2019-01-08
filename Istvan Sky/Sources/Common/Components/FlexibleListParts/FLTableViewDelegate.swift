//
//  FLTableViewDelegate.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol FLTableViewDelegate: UITableViewDelegate {
    init(presenter: FRProxyDataPresenter)
}

class FLTableViewDelegateImp: NSObject, FLTableViewDelegate {
    let presenter: FRProxyDataPresenter
    
    required init(presenter: FRProxyDataPresenter) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = IndexPath(item: 0, section: indexPath.section)
        presenter.didSelectItem(indexPath: selectedIndex, isChildListIndex: false)
    }
}
