//
//  ProjectRowView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ProjectRowView: View {
    var project: Project
    
    var body: some View {
        HStack {
            Text(project.name ?? "Unknown")
            Spacer()
            if Int((project.totalTime?.doubleValue ?? 0) / 3600) == 1 {
                Text("1 hour")
            } else {
                Text("\(Int((project.totalTime?.doubleValue ?? 0) / 3600)) hours")
            }
        }
    }
}

struct ProjectRowView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static var previews: some View {
        let previewProject = Project()
        previewProject.id = UUID()
        previewProject.name = "Test Project"
        previewProject.isWorkingOn = false
        previewProject.totalTime = NSNumber(value: 3600)
        previewProject.history = try! NSKeyedArchiver.archivedData(withRootObject: NSMutableArray(array: [
            DateInterval(start: Date(), end: Date().addingTimeInterval(TimeInterval(3600)))
        ]), requiringSecureCoding: false)
        try! context.save()
        
        return ProjectRowView(project: previewProject)
    }
}
