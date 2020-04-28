//
//  TimesheetTests.swift
//  TimesheetTests
//
//  Created by Preston Hager on 4/17/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import XCTest
@testable import Timesheet

class TimesheetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadingProjects() {
        // Inject testing projects into model first.
        let defaults = UserDefaults.standard
        let testProject = Project(name: "TestProject")
        defaults.set(try! JSONEncoder().encode(testProject), forKey: "Project_TestProject")
        defaults.set(["TestProject"], forKey: "ProjectNames")
        
        let model = Timesheet.ProjectManager(testing: true)
        XCTAssert(model.loaded)
    }
    
    func testAddingProjects() {
        let testProject = Project(name: "TestProject")
        
        let model = Timesheet.ProjectManager(testing: true)
        model.addProject(testProject)
        
        XCTAssert(model.projects.count == 1)

    }
    
}
