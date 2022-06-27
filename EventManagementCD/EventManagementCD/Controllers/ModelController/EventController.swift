//
//  EventController.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import CoreData

class EventController {
    
    // MARK: - Singleton
    static var shared = EventController()
    
    let scheduler = NotificationScheduler()
    
    private init() {}
    
    // MARK: - source of truth
    var events: [Event] = []
    var sections: [[Event]] { [attendingEvent, notAttendingEvent] }
    var attendingEvent: [Event] = []
    var notAttendingEvent: [Event] = []
    
    // MARK: - Computed Property
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    } ()
    
    // MARK: - CRUD
    //create
    func createEvent(title: String, eventDate: Date) {
        let event = Event(title: title, eventDate: eventDate)
        notAttendingEvent.append(event)
        CoreDataStack.saveContext()
        
        scheduler.scheduleNotification(for: event)
    }
    //read
    func fetchEvent(){
        events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
    }
    //update
    func updateEvent(event: Event, title: String, eventDate: Date) {
        event.title = title
        event.eventDate = eventDate
        CoreDataStack.saveContext()
        //handle notification
        scheduler.clearNotifications(for: event)
        scheduler.scheduleNotification(for: event)
    }
    func updateAttendingStatus(_ isAttending: Bool, event: Event) {
        if isAttending{
            scheduler.clearNotifications(for: event)
            if let index = notAttendingEvent.firstIndex(of: event) {
                notAttendingEvent.remove(at: index)
                attendingEvent.append(event)
            }
        }
    }
    func toggleAttending(event: Event) {
        event.attending.toggle()
        CoreDataStack.saveContext()
    }
    //delete
    func deleteEvent(event: Event) {
        guard let index = events.firstIndex(of: event) else { return }
        events.remove(at: index)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
        scheduler.clearNotifications(for: event)
    }
 
}//End of class


