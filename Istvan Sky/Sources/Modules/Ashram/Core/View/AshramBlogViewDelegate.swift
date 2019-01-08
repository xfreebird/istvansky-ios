//
//  AshramBlogViewDelegate.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/5/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol AshramBlogViewDelegate: UITableViewDelegate {
    init(presenter: AshramPresenter)
}

class AshramBlogViewDelegateImp: NSObject, AshramBlogViewDelegate {
    let presenter: AshramPresenter
    
    required init(presenter: AshramPresenter) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.itemSelected(index: indexPath.section)
    }
}
