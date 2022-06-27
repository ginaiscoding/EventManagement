//
//  Event+Convenience.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import CoreData

extension Event {
    
    @discardableResult convenience init(title: String, attending: Bool = false, eventDate: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.attending = attending
        self.eventDate = eventDate
        self.id = UUID().uuidString
    }
}
