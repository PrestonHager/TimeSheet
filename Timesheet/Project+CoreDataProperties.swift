//
//  Project+CoreDataProperties.swift
//  Timesheet
//
//  Created by Preston Hager on 4/28/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//
//

import Foundation
import CoreData


extension Project: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isWorkingOn: Bool
    @NSManaged public var workingStartTime: Date?
    @NSManaged public var totalTime: NSNumber?
    @NSManaged public var history: NSMutableArray?
    @NSManaged public var lastWorkedOn: Date?

    func toggle() {
        if (isWorkingOn) {
            // Add the current time interval to history and add to totalTime.
            lastWorkedOn = Date()
            let interval = DateInterval(start: workingStartTime!, end: lastWorkedOn!)
            history?.add(interval)
            addTotalTime(interval.duration)
        } else {
            // Create a workingStartTime of now.
            workingStartTime = Date()
        }
        isWorkingOn.toggle()
    }
    
    func addTime(start: Date, end: Date) {
        if (lastWorkedOn == nil || end > lastWorkedOn!) {
            lastWorkedOn = end
        }
        let interval = DateInterval(start: start, end: end)
         history?.add(interval)
        addTotalTime(interval.duration)
    }
    
    func addTotalTime(_ time: Double) {
        if (totalTime != nil) {
            totalTime = NSNumber(value: totalTime!.doubleValue + time)
        } else {
            totalTime = NSNumber(value: time)
        }
    }
    
}
