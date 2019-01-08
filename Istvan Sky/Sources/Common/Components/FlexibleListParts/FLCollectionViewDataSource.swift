//
//  FLCollectionViewDataSource.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/3/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol FLCollectionViewDataSource: UICollectionViewDataSource {
    init(presenter: FRProxyDataPresenter)
}

class FLCollectionViewDataSourceImp: NSObject, FLCollectionViewDataSource {
    let presenter: FRProxyDataPresenter
    
    required init(presenter: FRProxyDataPresenter) {
        self.presenter = presenter
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionIndex = collectionView.tag
        return presenter.itemsCount(sectionIndex: sectionIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = FLBasicItemCollectionViewCell.self
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType),
                                                      for: indexPath) as! FLBasicItemCollectionViewCell
        let sectionIndex = collectionView.tag
        let itemIndexPath = IndexPath(item: indexPath.item,
                                      section: sectionIndex)
        let viewModel = presenter.itemAtIndexPath(indexPath: itemIndexPath, isChildListIndex: true)
        cell.updateView(viewModel: viewModel)

        return cell
    }
}
