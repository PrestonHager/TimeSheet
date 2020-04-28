//
//  ProjectManager.swift
//  Timesheet
//
//  Created by Preston Hager on 4/22/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import Foundation

class ProjectManager: ObservableObject {
    @Published var projects = [Project]()
    @Published var loaded = false

    private let defaults = UserDefaults.standard
    private var projectNames = [String]()
    
    init(testing: Bool = false) {
        if case self.projectNames = defaults.stringArray(forKey: "ProjectNames") {
            for name in projectNames {
                // Load the project from JSON and add it to the projects.
                let projectData = defaults.data(forKey: "Project_\(name)")
                let project = try! JSONDecoder().decode(Project.self, from: projectData!)
                projects.append(project)
            }
        } else {
            // No saved projects yet.
            defaults.set([], forKey: "ProjectNames")
        }
        
        loaded = true
    }
    
    func addProject(_ project: Project) {
        projects.append(project)
        
        projectNames.append(project.name)
        defaults.set(projectNames, forKey: "ProjectNames")
        
        let projectData = try! JSONEncoder().encode(project)
        defaults.set(projectData, forKey: "Project_\(project.name)")
    }
    
    func removeProject(_ projectName: String) {
        projectNames = projectNames.filter {$0 != projectName}
        defaults.set(projectNames, forKey: "ProjectNames")
        
        projects = projects.filter {$0.name != projectName}
        defaults.set(nil, forKey: "Project_\(projectName)")
    }
    
    func saveProjects() {
        let encoder = JSONEncoder()
        
        for project in projects {
            let projectData = try! encoder.encode(project)
            defaults.set(projectData, forKey: "Project_\(project.name)")
        }
    }
}
