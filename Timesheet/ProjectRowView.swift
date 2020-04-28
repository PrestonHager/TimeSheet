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
            Text(project.name)
            Spacer()
            if Int(project.totalTime / 3600) == 1 {
                Text("1 hour")
            } else {
                Text("\(Int(project.totalTime / 3600)) hours")
            }
        }
    }
}

struct ProjectRowView_Previews: PreviewProvider {
    static var previewProject = Project(name: "Test Project")
    
    static var previews: some View {
        return ProjectRowView(project: previewProject)
    }
}
