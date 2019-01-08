//
//  FRProxyDataPresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

protocol FRProxyDataPresenter: class {
    func didSelectItem(indexPath: IndexPath, isChildListIndex: Bool)
    func itemAtIndexPath(indexPath: IndexPath, isChildListIndex: Bool) -> FLViewModel
    func sectionsCount() -> Int
    func itemsCount(sectionIndex: Int) -> Int
    func processAction(for type: FLViewModelType)
}
