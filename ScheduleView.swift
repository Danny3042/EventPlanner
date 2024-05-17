//
//  ScheduleView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 17/05/2024.
//

import SwiftUI

struct ScheduleView: View {
    @State private var showingAddEventForm = false
    @State private var calendarView = CalendarView()
    var body: some View {
        VStack {
            calendarView
            Button(action: {
                showingAddEventForm = true
            }) {
                Text("Add Event")
            }
        }
        .sheet(isPresented: $showingAddEventForm) {
            AddEventForm(calendarView: $calendarView)
        }
    }
}

struct AddEventForm: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var calendarView: CalendarView
    @State private var date = Date()
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date,displayedComponents: .date)
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarItems(leading: Button("Cancel", action: dismiss.callAsFunction), trailing: Button("Add", action: addEvent))
        }
    }
    private func addEvent() {
        let event = Event(date: date, title: title, description: description)
        calendarView.addEvent(event)
        dismiss()
    }
}

#Preview {
    ScheduleView()
}
