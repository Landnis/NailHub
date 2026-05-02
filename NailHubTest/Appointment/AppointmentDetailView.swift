//
//  AppointmentDetailView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI

struct AppointmentDetailView: View {
    let appointment: AppointmentModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.accentColor)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appointment.clientName)
                                .font(.title.bold())
                            
                            // Προσθέτουμε έναν έλεγχο: αν δεν υπάρχει υπηρεσία, βάλε ένα Placeholder
                            Text(appointment.service.isEmpty ? "Δεν ορίστηκε υπηρεσία" : appointment.service)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                    
                    // Στοιχεία Επικοινωνίας & Ραντεβού
                    DetailRow(icon: "phone.fill", title: "Τηλέφωνο", value: appointment.clientPhone)
                    DetailRow(icon: "calendar", title: "Ημερομηνία", value: appointment.date.formatted(date: .long, time: .omitted))
                    DetailRow(icon: "clock", title: "Ώρα", value: appointment.date.formatted(date: .omitted, time: .shortened))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ΣΗΜΕΙΩΣΕΙΣ").font(.caption).foregroundColor(.secondary)
                        Text(appointment.notes.isEmpty ? "Καμία σημείωση..." : appointment.notes)
                            .font(.body)
                            .italic(appointment.notes.isEmpty)
                    }
                    .padding(.top, 5)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
                .shadow(radius: 5)
                
                // Κουμπί για γρήγορη κλήση
                Button(action: {
                    let telephone = "tel://" + appointment.clientPhone
                    if let url = URL(string: telephone) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Label("Κλήση Πελάτισσας", systemImage: "phone.arrow.up.right")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
            }
            .padding()
        }
        .navigationTitle("Στοιχεία Ραντεβού")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Βοηθητικό View για τις γραμμές της κάρτας
struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
        
                Text(value.isEmpty ? "---" : value)
                    .font(.body)
            }
        }
    }
}


#Preview {
    AppointmentDetailView(appointment: AppointmentModel(
        timestamp: Date(),
        clientName: "Καλλιόπη",
        service: "Τζελ",
        clientPhone: "697ΧΧ4533",
        notes: "")
    )
}
