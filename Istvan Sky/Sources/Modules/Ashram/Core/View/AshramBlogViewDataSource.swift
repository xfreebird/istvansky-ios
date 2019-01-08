//
//  AshramBlogViewDataSource.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/5/19.
//  Copyright © 2019 GMBN. All rights reserved.
//


import UIKit

protocol AshramBlogViewDataSource: UITableViewDataSource {
    init(presenter: AshramPresenter)
}

class AshramBlogViewDataSourceImp: NSObject, AshramBlogViewDataSource {
    let presenter: AshramPresenter
    
    required init(presenter: AshramPresenter) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = String(describing: AshramBlogItemTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType) as! AshramBlogItemTableViewCell
        
        let viewModel = presenter.item(index: indexPath.section)
        cell.updateView(viewModel: viewModel)
        return cell
    }
}
