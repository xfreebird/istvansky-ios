//
//  TourEventsViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import EventKitUI

protocol TourEventsView: class {
    func updateView()
    func showNoEvents()
    func showMoreScreen(itemIndex: Int)
    func showShareScreen(itemIndex: Int, message: String, url: URL)
    func showAddEvent(for event: EKEvent, eventStore: EKEventStore) 
}

class TourEventsViewController: BaseViewController, TourEventsView {
    var presenter: TourEventsPresenter!
    var tableViewDataSource: TourEventsDataSource!
    var tableViewDelegate: TourEventsDelegate!
    
    @IBOutlet weak var noEventsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemCellType = String(describing: TourEventTableViewCell.self)
        
        tableView.register(UINib(nibName: itemCellType, bundle: nil), forCellReuseIdentifier: itemCellType)
        
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = flowerTableViewBackground()
        tableView.refreshControl = refreshControl
        presenter.viewDidLoad()
    }
    
    override func reloadData() {
        presenter.reloadData()
    }
    
    func updateView() {
        refreshControl.endRefreshing()
        noEventsLabel.isHidden = true
        tableView.isHidden = false
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
    }
    
    func showNoEvents() {
        noEventsLabel.isHidden = false
        tableView.isHidden = true
    }

    func showMoreScreen(itemIndex: Int) {
        let addToCalendarAction = UIAlertAction(title: NSLocalizedString("Add to calendar", comment: ""),
                                                style: .default) { [weak self] (action) in
            self?.presenter.addToCalendar(index: itemIndex)
        }
        
        let shareAction = UIAlertAction(title: NSLocalizedString("Share", comment: ""),
                                        style: .default) { [weak self] (action) in
            self?.presenter.shareItem(index: itemIndex)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                         style: .cancel)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(addToCalendarAction)
        alert.addAction(shareAction)
        alert.addAction(cancelAction)
        
        presentController(itemIndex: itemIndex, alert: alert)
    }
    
    func showShareScreen(itemIndex: Int, message: String, url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.assignToContact,
                                                        .openInIBooks,
                                                        .print,
                                                        .saveToCameraRoll,
                                                        .postToWeibo,
                                                        .postToFlickr,
                                                        .postToVimeo
        ]
        
        
        presentController(itemIndex: itemIndex, alert: activityViewController)
    }
    
    func presentController(itemIndex: Int, alert: UIViewController) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let eventCell = tableViewCell(at: itemIndex)
            alert.popoverPresentationController?.sourceView = eventCell?.shareButton
            alert.popoverPresentationController?.sourceRect = eventCell?.shareButton.bounds ?? CGRect.zero
        }
        present(alert, animated: true)
    }

    func tableViewCell(at index: Int) -> TourEventTableViewCell? {
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)), cell is TourEventTableViewCell {
            let eventCell = cell as! TourEventTableViewCell
            return eventCell
        }
        return nil
    }

}

extension TourEventsViewController: EKEventEditViewDelegate {
    func showAddEvent(for event: EKEvent, eventStore: EKEventStore) {
        let calendarController = EKEventEditViewController()
        calendarController.event = event
        calendarController.eventStore = eventStore
        calendarController.editViewDelegate = self
        present(calendarController, animated: true)
    }

    func eventEditViewController(_ controller: EKEventEditViewController,
                                 didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
