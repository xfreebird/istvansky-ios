//
//  FLCollectionViewTableViewCell.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 12/27/18.
//  Copyright © 2018 GMBN. All rights reserved.
//

import UIKit

class FLCollectionViewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let size = CGSize(width: 285, height: 215)

    weak var dataSource: FLCollectionViewDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }
    weak var delegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let cellType = String(describing: FLBasicItemCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellType, bundle: nil),
                                forCellWithReuseIdentifier: String(describing: cellType))
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = size
        }
    }
    
    func updateView(viewModel: FLViewModel, section: Int) {
        titleLabel.text = viewModel.title
        collectionView.tag = section
    }
}
