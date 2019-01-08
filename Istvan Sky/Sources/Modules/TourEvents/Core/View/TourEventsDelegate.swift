//
//  TourEventsDelegate.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol TourEventsDelegate: UITableViewDelegate {
    init(presenter: TourEventsPresenter)
}

class TourEventsDelegateImp: NSObject, TourEventsDelegate {
    let presenter: TourEventsPresenter
    
    required init(presenter: TourEventsPresenter) {
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
