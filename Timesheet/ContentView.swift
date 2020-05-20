//
//  ContentView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.name, ascending: true)]) var projects: FetchedResults<Project>
    
    @State var showAddProjectView = false
    @State var updateProjectView = false
    
    var body: some View {
        NavigationView {
            // TODO: find a better solution to updating this view as this does cause some jitteriness.
            if (updateProjectView) {
                Text("Updating")
                .onAppear {
                    self.updateProjectView = false
                }
            }
            List {
                ForEach(projects, id: \.id) { project in
                    NavigationLink(destination: ProjectView(project: project, updateProjectView: self.$updateProjectView)) {
                        HStack {
                            ProjectRowView(project: project)
                        }
                    }
                }.onDelete(perform: deleteProjects)
            }
            .navigationBarTitle("Timesheet")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showAddProjectView.toggle()
                }) {
                Image(systemName: "plus")
                    .padding()
                    .imageScale(.large)
            })
        }.sheet(isPresented: $showAddProjectView) {
            NewProjectView().environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
    
    func deleteProjects(at offsets: IndexSet) {
        for offset in offsets {
            let project = projects[offset]
            managedObjectContext.delete(project)
        }
        try? managedObjectContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static var previews: some View {
        return ContentView().environment(\.managedObjectContext, context)
    }
}
