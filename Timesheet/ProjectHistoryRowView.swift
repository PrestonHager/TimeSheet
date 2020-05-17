//
//  ProjectHistoryRowView.swift
//  Timesheet
//
//  Created by Preston Hager on 5/1/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct ProjectHistoryRowView: View {
    var interval: DateInterval
    
    private let dateFormatterStart = DateFormatter()
    private let dateFormatterEnd = DateFormatter()
    
    init(interval: DateInterval) {
        self.interval = interval
        
        dateFormatterStart.dateFormat = "d MMM y, HH:mm"
        dateFormatterEnd.dateFormat = "HH:mm"
    }
    
    var body: some View {
        HStack {
            Text(getIntervalString())
        }.padding()
    }
    
    func getIntervalString() -> String {
        if (interval.duration <= 86400.0) { // seconds in a day
            return "\(self.dateFormatterStart.string(from: self.interval.start)) to \(self.dateFormatterEnd.string(from: self.interval.end))"
        } else {
            return "\(self.dateFormatterStart.string(from: self.interval.start)) to \(self.dateFormatterStart.string(from: self.interval.end))"
        }
    }
}

struct ProjectHistoryRowView_Previews: PreviewProvider {
    static var intervalPreview = DateInterval(start: Date(), end: Date()+3600)
    static var intervalPreview2 = DateInterval(start: Date(), end: Date()+86500)
    
    static var previews: some View {
        VStack {
            ProjectHistoryRowView(interval: intervalPreview)
            ProjectHistoryRowView(interval: intervalPreview2)
        }
    }
}
