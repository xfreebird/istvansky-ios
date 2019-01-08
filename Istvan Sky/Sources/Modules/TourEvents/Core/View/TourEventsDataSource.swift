//
//  TourEventsDataSource.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//


import UIKit

protocol TourEventsDataSource: UITableViewDataSource {
    init(presenter: TourEventsPresenter)
}

class TourEventsDataSourceImp: NSObject, TourEventsDataSource {
    let presenter: TourEventsPresenter
    
    required init(presenter: TourEventsPresenter) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = String(describing: TourEventTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType) as! TourEventTableViewCell
        let viewModel = presenter.itemAtIndexPath(indexPath: indexPath)
        cell.updateView(viewModel: viewModel)
        cell.presenter = presenter
        cell.tag = indexPath.section
        return cell
    }
}
