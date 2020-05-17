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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects, id: \.id) { project in
                    NavigationLink(destination: ProjectView(project: project)) {
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
            NewProjectView()
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
