//
//  ProjectView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    var project: Project
    
    // Adding a specific time view's variables.
    @State var showAddTime = false
    @State var addTime = false
    @State var addTimeStart: Date = Date()
    @State var addTimeEnd: Date = Date().addingTimeInterval(TimeInterval(3600))
    
    var body: some View {
        VStack {
            Button(action: {
                // what to do to start the clock.
                self.project.toggle()
                try? self.managedObjectContext.save()
            }) {
                VStack {
                    Image(systemName: project.isWorkingOn ? "square.fill" : "play.fill")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .padding()
                        .foregroundColor(.primary)
                    Text(project.isWorkingOn ? "Stop Working on Project" : "Start Working from Now")
                }.padding()
            }
            Button(action: {
                self.showAddTime.toggle()
            }) {
                Text("Add a Specific Time")
                .padding()
            }
            Divider()
                .padding(.horizontal)
            VStack {
                Text("Previous Work")
                    .padding()
                    .font(.headline)
                Text("Total hours worked on: \(Int((self.project.totalTime?.doubleValue ?? 0)/3600))")
                List(self.project.history! as! [DateInterval], id: \.self) { interval in
                    ProjectHistoryRowView(interval: interval)
                }
            }
            Spacer()
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        .sheet(isPresented: $showAddTime, onDismiss: {
            if (self.addTime) {
                // Add the time and then save the context to ensure that all changes are kept.
                self.project.addTime(start: self.addTimeStart, end: self.addTimeEnd)
                try? self.managedObjectContext.save()
            }
        }) {
            AddSpecificTimeSheetView(addTimeStart: self.$addTimeStart, addTimeEnd: self.$addTimeEnd, self.$addTime)
        }
        .navigationBarTitle("Project - \(project.name ?? "Unknown")")
            // Other Details Menu
            .navigationBarItems(trailing: Image(systemName: "ellipsis")
                .imageScale(.large)
                .padding()
        )
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        let previewProject = Project(context: context)
        previewProject.id = UUID()
        previewProject.name = "Test Project"
        previewProject.isWorkingOn = false
        previewProject.totalTime = NSNumber(value: 3600)
        previewProject.history = NSMutableArray(array: [
            DateInterval(start: Date(), end: Date().addingTimeInterval(TimeInterval(3600)))
        ])
        try! context.save()
        
        return ProjectView(project: previewProject).environment(\.managedObjectContext, context)
    }
}
