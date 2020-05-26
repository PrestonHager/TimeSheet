//
//  Extensions.swift
//  Timesheet
//
//  Created by Preston Hager on 4/21/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import Foundation

extension Int {
    func timeString() -> String {
        return self < 10 ? "0\(self)" : "\(self)"
    }
}

