//
//  AppointmentView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI
import SwiftData

struct AppointmentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var existingClients: [ExistingClientModel]
    
    @State private var clientName = ""
    @State private var service = ""
    @State private var date = Date()
    @State private var clientPhone = ""
    @State private var notes = ""
    @State private var showAlert = false
    
    private var isPastDate: Bool {
        date < Date()
    }
    
    private var phoneExists: Bool {
        existingClients.contains { $0.clientPhone == clientPhone }
    }
    
    private var isNameValid: Bool {
        !clientName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isPhoneValid: Bool {
        let digits = clientPhone.filter { $0.isNumber }
        return digits.count == 10
    }
    
    private var canSave: Bool {
        isNameValid && isPhoneValid
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Όνομα Πελάτισσας", text: $clientName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                TextField("Υπηρεσία", text: $service)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                TextField("Τηλέφωνο", text: $clientPhone)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                DatePicker("Ημερομηνία", selection: $date, in: Date()...)
            } header: {
                Text("Στοιχεία Ραντεβού")
            } footer: {
                Text("Βεβαιωθείτε ότι τα στοιχεία είναι σωστά πριν την αποθήκευση.")
            }
            
            Section("Σημειώσεις") {
                TextField("Γράψτε λεπτομέρειες για το ραντεβού (π.χ. χρώμα, σχέδιο)...", text: $notes, axis: .vertical)
                    .lineLimit(5...10)
            }
            
            Section {
                Button(action: {
                    if isPastDate {
                        showAlert = true
                    } else {
                        saveAppointment()
                        if !phoneExists {
                            saveClient()
                        }
                    }
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                        Text("Αποθήκευση Ραντεβού")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .shadow(radius: 4, x: 0, y: 4)
                .foregroundColor(AppTheme.nailHubBtnText)
                .listRowBackground(canSave ? Color.accentColor : Color.gray)
            }
            .disabled(!canSave)
        }
        .alert("Μη έγκυρη ημερομηνία", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Δεν μπορείτε να επιλέξετε ημερομηνία στο παρελθόν.")
        }
        .navigationTitle("Νέο Ραντεβού")
    }
    
    
    private func saveAppointment() {
        let newAppointment = AppointmentModel(
            timestamp: date,
            clientName: clientName,
            service: service,
            clientPhone: clientPhone,
            notes: notes
        )
        modelContext.insert(newAppointment)
        NotificationManager.shared.scheduleNotification(for: newAppointment)
        dismiss()
    }
    
    private func saveClient() {
        let newAppointment = ExistingClientModel(
            clientName: clientName,
            clientPhone: clientPhone
        )
        modelContext.insert(newAppointment)
    }
}

#Preview {
    AppointmentView()
}
