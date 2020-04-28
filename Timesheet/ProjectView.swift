//
//  ProjectView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ProjectView: View {
    @Binding var project: Project
    
    // Adding a specific time view's variables.
    @State var showAddTime = false
    @State var addTime = false
    @State var addTimeStart: Date = Date()
    @State var addTimeEnd: Date = Date().addingTimeInterval(TimeInterval(3600))

    private let dateFormatterStart = DateFormatter()
    private let dateFormatterEnd = DateFormatter()
    
    init(project: Binding<Project>) {
        _project = project
        UITableView.appearance().backgroundColor = .clear
        
        dateFormatterStart.dateFormat = "d MMM y, HH:mm"
        dateFormatterEnd.dateFormat = "HH:mm"
    }
    
    var body: some View {
        VStack {
            Button(action: {
                // what to do to start the clock.
                self.project.toggle()
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
                Text("Total hours worked on: \(Int(self.project.totalTime/3600))")
                List(self.project.history, id: \.self) { interval in
                    if (interval.duration < 86400.0) { // seconds in a day
                        HStack {
                            Text("\(self.dateFormatterStart.string(from: interval.start)) to \(self.dateFormatterEnd.string(from: interval.end))")
                            Spacer()
                            Text("\(Int(interval.duration/3600)):\(Int((interval.duration/60).truncatingRemainder(dividingBy: 60)).timeString())")
                        }.padding()
                    } else {
                        HStack {
                            Text("\(self.dateFormatterStart.string(from: interval.start)) to \(self.dateFormatterStart.string(from: interval.end))")
                        }.padding()
                    }
                }
            }
            Spacer()
            }
            .sheet(isPresented: $showAddTime, onDismiss: {
                if (self.addTime) {
                    self.project.addTime(start: self.addTimeStart, end: self.addTimeEnd)
                }
            }) {
                AddSpecificTimeSheetView(addTimeStart: self.$addTimeStart, addTimeEnd: self.$addTimeEnd, self.$addTime)
            }
            .navigationBarTitle("Project View")
            // Other Details Menu
            .navigationBarItems(trailing: Image(systemName: "ellipsis")
                .imageScale(.large)
                .padding()
        )
    }
}

struct ProjectView_Previews: PreviewProvider {
    @State static var previewProject = Project(name: "Test Project")
    
    static var previews: some View {
        return ProjectView(project: $previewProject)
    }
}
