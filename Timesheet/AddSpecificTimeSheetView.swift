//
//  AddSpecificTimeSheetView.swift
//  Timesheet
//
//  Created by Preston Hager on 4/19/20.
//  Copyright © 2020 Hager Family. All rights reserved.
//

import SwiftUI

struct AddSpecificTimeSheetView: View {
    @Binding var addTimeStart: Date
    @Binding var addTimeEnd: Date
    @Binding var setTime: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    init(addTimeStart: Binding<Date>, addTimeEnd: Binding<Date>, _ setTime: Binding<Bool>) {
        _addTimeStart = addTimeStart
        _addTimeEnd = addTimeEnd
        _setTime = setTime
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Use the pickers below to select a start and end date for the time you want to add.")
                    // TODO: make custom date picker views using UIDatePicker so that we can use the minuteInterval.
                    DatePicker("Start", selection: self.$addTimeStart)
                    DatePicker("End", selection: self.$addTimeEnd)
                }
            }
            .navigationBarTitle("Add a Specific Time")
            .navigationBarItems(leading: Button(action: {
                self.setTime = false
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                self.setTime = true
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
        }
    }
}

struct AddSpecificTimeSheetView_Previews: PreviewProvider {
    @State static var previewAddTimeStart = Date()
    @State static var previewAddTimeEnd = Date().addingTimeInterval(TimeInterval(3600))
    @State static var previewSetTime = false

    static var previews: some View {
        AddSpecificTimeSheetView(addTimeStart: $previewAddTimeStart, addTimeEnd: $previewAddTimeEnd, $previewSetTime)
    }
}
