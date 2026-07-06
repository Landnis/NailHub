//
//  EditAppointmentView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI

struct EditAppointmentView: View {
    @Bindable var appointment: AppointmentModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Βασικά Στοιχεία") {
                    TextField("Όνομα", text: $appointment.clientName)
                    TextField("Υπηρεσία", text: $appointment.service)
                    TextField("Τηλέφωνο", text: $appointment.clientPhone)
                        .keyboardType(.phonePad)
                }
                
                Section("Πότε;") {
                    DatePicker("Ημερομηνία", selection: $appointment.date)
                }
                
                Section("Επιπλέον Πληροφορίες") {
                    TextEditor(text: $appointment.notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Επεξεργασία")
            .toolbar {
                Button("Τέλος") {
                    NotificationManager.shared.removeNotification(for: appointment)
                    NotificationManager.shared.scheduleNotification(for: appointment)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    EditAppointmentView(appointment: AppointmentModel(
        timestamp: Date(),
        clientName: "",
        service: "",
        clientPhone: "",
        notes: "")
    )
}
