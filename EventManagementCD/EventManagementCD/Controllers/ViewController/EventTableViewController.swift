//
//  EventTableViewController.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchEvent()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.shared.fetchEvent()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell()}
        
        let event = EventController.shared.events[indexPath.row]
        cell.event = event
        cell.eventLabel.text = event.title
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(event: event)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController
            else { return }
            let event = EventController.shared.events[indexPath.row]
            destination.event = event
        }
    }
    
}//end of class

extension EventTableViewController: EventAttendingDelegate {
    func eventCellButtontapped(sender: EventTableViewCell) {
        guard let event = sender.event else { return }
        EventController.shared.toggleAttending(event: event)
        sender.updateViews()
    }
}
