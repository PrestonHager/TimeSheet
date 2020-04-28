//
//  ContentView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var projectManager: ProjectManager
    
    var body: some View {
        NavigationView {
            List(projectManager.projects.indices, id: \.self) { index in
                NavigationLink(destination: ProjectView(project: Binding(
                    get: { return self.projectManager.projects[index] },
                    set: { newValue in return self.projectManager.projects[index] = newValue }
                ))) {
                    ProjectRowView(project: self.projectManager.projects[index])
                }
            }
            .navigationBarTitle("Timesheet")
            .navigationBarItems(trailing: NavigationLink(destination: NewProjectView()) {
                Image(systemName: "plus")
                    .padding()
                    .imageScale(.large)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previewProjectManager = ProjectManager()
    
    static var previews: some View {
        return ContentView().environmentObject(previewProjectManager)
    }
}
