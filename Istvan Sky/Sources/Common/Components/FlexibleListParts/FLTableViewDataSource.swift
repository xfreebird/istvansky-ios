//
//  FLTableViewDataSource.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/3/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol FLTableViewDataSource: UITableViewDataSource {
    init(presenter: FRProxyDataPresenter,
         collectionViewDataSource: FLCollectionViewDataSource?,
         collectionViewDelegate: FLCollectionViewDelegate?)
}

class FLTableViewDataSourceImp: NSObject, FLTableViewDataSource {
    let presenter: FRProxyDataPresenter
    weak var collectionViewDataSource: FLCollectionViewDataSource?
    weak var collectionViewDelegate: FLCollectionViewDelegate?

    required init(presenter: FRProxyDataPresenter,
                  collectionViewDataSource: FLCollectionViewDataSource?,
                  collectionViewDelegate: FLCollectionViewDelegate?) {
        self.presenter = presenter
        self.collectionViewDataSource = collectionViewDataSource
        self.collectionViewDelegate = collectionViewDelegate
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemIndexPath = IndexPath(item: 0, section: indexPath.section)
        let viewModel = presenter.itemAtIndexPath(indexPath: itemIndexPath, isChildListIndex: false)
        let isItemWithList = viewModel.items != nil && !viewModel.hideItemsPreview
        var cellType = String(describing: FLTableViewCell.self)
        
        if viewModel.type == .support {
            cellType = String(describing: FLMediaTableViewCell.self)
        } else if isItemWithList {
            cellType = String(describing: FLCollectionViewTableViewCell.self)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType)!
        
        if isItemWithList {
            let listCell = cell as! FLCollectionViewTableViewCell
            listCell.updateView(viewModel: viewModel, section: indexPath.section)
            listCell.delegate = collectionViewDelegate
            listCell.dataSource = collectionViewDataSource
        } else if viewModel.type == .support {
            let basicCell = cell as! FLMediaTableViewCell
            basicCell.updateView(viewModel: viewModel)
            basicCell.presenter = presenter
        } else {
            let basicCell = cell as! FLTableViewCell
            basicCell.updateView(viewModel: viewModel)
        }

        return cell
    }
}
