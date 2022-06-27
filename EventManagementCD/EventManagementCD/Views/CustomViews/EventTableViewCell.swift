//
//  EventTableViewCell.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import UIKit

protocol EventAttendingDelegate: AnyObject {
    func eventCellButtontapped(sender: EventTableViewCell)
}
class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var attendingButton: UIButton!
    
    weak var delegate: EventAttendingDelegate?
    
    var event: Event?
    
    
    // MARK: - ACtions
    @IBAction func attendingButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.eventCellButtontapped(sender: self)
        }
    }
    func updateViews() {
        guard let event = event else { return }
        eventLabel.text = event.title
        let imageName = event.attending ? "checkmark" : "xmark"
        let image = UIImage(systemName: imageName)
        attendingButton.setImage(image, for: .normal)
    }
    
}
