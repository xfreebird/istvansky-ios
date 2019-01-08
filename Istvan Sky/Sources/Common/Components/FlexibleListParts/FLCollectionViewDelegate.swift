//
//  FLCollectionViewDelegate.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

protocol FLCollectionViewDelegate: UICollectionViewDelegate {
    init(presenter: FRProxyDataPresenter)
}

class FLCollectionViewDelegateImp: NSObject, FLCollectionViewDelegate {
    let presenter: FRProxyDataPresenter
    
    required init(presenter: FRProxyDataPresenter) {
        self.presenter = presenter
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionIndex = collectionView.tag
        let itemIndexPath = IndexPath(item: indexPath.item,
                                      section: sectionIndex)
        presenter.didSelectItem(indexPath: itemIndexPath, isChildListIndex: true)

    }
}
