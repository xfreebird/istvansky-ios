//
//  DonateViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import SnapKit

protocol DonateView: class {
    func updateView(viewModel: FLViewModel)
}

class DonateViewController: BaseViewController, DonateView {
    
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var donateImageView: UIImageView!
    @IBOutlet weak var donateLabel: UITextView!
    
    var presenter: DonatePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupLabel()
        presenter.viewDidLoad()
    }
    
    func setupLabel() {
        donateLabel.layer.shadowColor = UIColor.black.cgColor
        donateLabel.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        donateLabel.layer.shadowOpacity = 1.0
        donateLabel.layer.shadowRadius = 1.0
        donateLabel.layer.backgroundColor = UIColor.clear.cgColor

    }
    func updateView(viewModel: FLViewModel) {
        title = viewModel.title
        donateLabel.text = viewModel.description
        donateImageView.image = UIImage(named: "donate")
        donateButton.configure(title: viewModel.title, isHighlighted: true)
    }
    
    @IBAction func donateAction(_ sender: Any) {
        presenter.donate()
    }
}
