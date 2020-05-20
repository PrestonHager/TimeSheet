//
//  NewProjectView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct NewProjectView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var projectName: String = ""

    @State var validationErrored = false
    @State var showErrorMessage = false
    @State var errorMessage = "Some error message."
    // TODO: turn errored fields red to alert user.
    // @State var invalidFields = {}
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Project Name", text: $projectName)
                    .autocapitalization(.words)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
                Button(action: {
                    // Don't forget to validate the parameters!
                    if (self.validate()) {
                        // What to do if we want to add the project described.
                        let newProject = Project(context: self.managedObjectContext)
                        newProject.id = UUID()
                        newProject.name = self.projectName
                        newProject.isWorkingOn = false
                        newProject.totalTime = NSNumber(value: 0)
                        newProject.history = NSMutableArray()
                        // Add project to database by just saving the context.
                        try? self.managedObjectContext.save()
                        // And then dismiss this view to go back to the home screen.
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                        .font(.system(size: 24.0))
                        .bold()
                        .padding()
                }.padding()
            }
            .navigationBarTitle("New Project", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
            .alert(isPresented: $showErrorMessage) {
                Alert(title: Text("Added New Project Failed"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func validate() -> Bool {
        validationErrored = false
        if (projectName == "") {
            errorMessage = "Project Name must not be empty."
            validationErrored = true
        }
        showErrorMessage = validationErrored
        return !validationErrored
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static var previews: some View {
        // NOTE: you must play the preview to view this.
        NewProjectView().environment(\.managedObjectContext, context)
    }
}
