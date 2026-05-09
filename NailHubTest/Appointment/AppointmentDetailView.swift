//
//  AppointmentDetailView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI

struct AppointmentDetailView: View {
    let appointment: AppointmentModel
    @State private var showEditScreen = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 15) {
                    headerSection
                    
                    Divider()
                    
                    detailsSection
                    
                    notesSection
                }
                .padding()
                .background(AppTheme.nailHubCream)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                callButton
            }
            .sheet(isPresented: $showEditScreen) {
                EditAppointmentView(appointment: appointment)
            }
            .padding()
        }
        .navigationTitle("Στοιχεία Ραντεβού")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension AppointmentDetailView {
    var headerSection: some View {
        HStack(spacing: 16) {
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.accentColor)
                .overlay(alignment: .bottomTrailing) {
                    
                    Button {
                        showEditScreen = true
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppTheme.nailHubBtnText)
                            .padding(6)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .offset(x: 4, y: 4)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(appointment.clientName)
                    .font(.title2.bold())
                
                Text(
                    appointment.service.isEmpty
                    ? "Δεν ορίστηκε υπηρεσία"
                    : appointment.service
                )
                .font(.headline)
                .foregroundColor(.secondary)
            }
        }
    }
    
    var detailsSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            
            DetailRow(
                icon: "phone.fill",
                title: "Τηλέφωνο",
                value: appointment.clientPhone
            )
            
            DetailRow(
                icon: "calendar",
                title: "Ημερομηνία",
                value: appointment.date.formatted(
                    date: .long,
                    time: .omitted
                )
            )
            
            DetailRow(
                icon: "clock",
                title: "Ώρα",
                value: appointment.date.formatted(
                    date: .omitted,
                    time: .shortened
                )
            )
        }
    }
    
    var notesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("ΣΗΜΕΙΩΣΕΙΣ")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            Text(
                appointment.notes.isEmpty
                ? "Καμία σημείωση..."
                : appointment.notes
            )
            .font(.body)
            .foregroundColor(
                appointment.notes.isEmpty
                ? .secondary
                : .primary
            )
            .italic(appointment.notes.isEmpty)
        }
        .padding(.top, 5)
    }
    
    var callButton: some View {
        Button {
            callClient()
        } label: {
            
            Label(
                "Κλήση Πελάτισσας",
                systemImage: "phone.arrow.up.right"
            )
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(AppTheme.nailHubBtnText)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .shadow(radius: 4, x: 0, y: 4)
        }
        .shadow(radius: 4, x: 0, y: 4)
    }
    
    func callClient() {
        let telephone = "tel://\(appointment.clientPhone)"
        
        guard let url = URL(string: telephone) else { return }
        
        UIApplication.shared.open(url)
    }
}


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
