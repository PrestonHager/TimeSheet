//
//  NewProjectView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct NewProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var projectManager: ProjectManager
    
    @State var projectName: String = ""

    @State var validationErrored = false
    @State var errorMessage = "Some error message."
    // TODO: turn errored fields red to alert user.
    // @State var invalidFields = {}
    
    var body: some View {
        VStack {
            HStack {
                Text(validationErrored ? "Error: \(errorMessage)" : "")
                    .bold()
                    .foregroundColor(.red)
                    .padding()
            }
            TextField("Project Name", text: $projectName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
            Button(action: {
                // Don't forget to validate the parameters!
                if (self.validate()) {
                    // What to do if we want to add the project described.
                    let newProject = Project(name: self.projectName)
                    self.projectManager.addProject(newProject)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Add")
//                    .font(.system(size: 24.0))
                    .bold()
                    .padding()
            }.padding()
        }
        .navigationBarTitle("New Project")
    }
    
    func validate() -> Bool {
        validationErrored = false
        if (projectName == "") {
            errorMessage = "Project Name must not be empty."
            validationErrored = true
        }
        return !validationErrored
    }
}

struct NewProjectView_Previews: PreviewProvider {    
    static var previews: some View {
        NewProjectView().environmentObject(ProjectManager())
    }
}
