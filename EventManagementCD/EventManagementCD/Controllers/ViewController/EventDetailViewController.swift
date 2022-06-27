//
//  EventDetailViewController.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    var event: Event?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = eventTitleTextField.text, !title.isEmpty else { return }
        
        let eventDate = eventDatePicker.date
        
        if let event = event {
            EventController.shared.updateEvent(event: event, title: title, eventDate: eventDate)
        } else {
            EventController.shared.createEvent(title: title, eventDate: eventDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventDatePickerChanged(_ sender: Any) {
        self.date = eventDatePicker.date
    }
    
    func updateViews() {
        guard let event = event else { return }
        eventTitleTextField.text = event.title
        eventDatePicker.date = event.eventDate ?? Date()
    }
    
}//end of class
