//
//  Project.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import Foundation

struct SProject: Identifiable, Codable {
    // Unchanging variables
    let id = UUID()
    let startTime = Date()
    
    // Attributes that the user has controll over.
    var name: String
    
    // Attributes that are automatically changed.
    var isWorkingOn: Bool = false
    var workingStartTime: Date? = nil
    var history: [DateInterval] = []
    var totalTime: TimeInterval = TimeInterval(0)
    var lastWorkedOn: Date? = nil
    
    mutating func toggle() {
        if (self.isWorkingOn) {
            // If we are currently working on the project, then we are stopping it.
            let interval = DateInterval(start: self.workingStartTime!, end: Date())
            self.history.append(interval)
            self.totalTime += interval.duration
        } else {
            // Otherwise, we are starting it.
            self.workingStartTime = Date()
        }
        self.isWorkingOn.toggle()
        self.lastWorkedOn = Date()
    }
    
    mutating func addTime(start: Date, end: Date) {
        let interval = DateInterval(start: start, end: end)
        self.history.append(interval)
        self.totalTime += interval.duration
        self.lastWorkedOn = Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case name = "name"
        case isWorkingOn = "is_working_on"
        case workingStartTime = "working_start_time"
        case history = "history"
        case totalTime = "total_time"
        case lastWorkedOn = "last_worked_on"
    }
}
