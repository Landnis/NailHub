//
//  HistoryAppointmentScreen.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 25/4/26.
//

import SwiftUI
import SwiftData

struct HistoryAppointmentScreen: View {
    @Query(
        filter: #Predicate<AppointmentModel> { $0.isCompleted },
        sort: \.date,
        order: .reverse
    )
    private var completedAppointments: [AppointmentModel]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomLeading) {
                if completedAppointments.isEmpty {
                    ContentUnavailableView(
                        "Κενό Ιστορικό",
                        systemImage: "clock.arrow.circlepath",
                        description: Text("Δεν υπάρχουν ολοκληρωμένα ραντεβού.")
                    )
                    .listRowBackground(Color.clear)
                } else {
                    List {
                        ForEach(completedAppointments) { appointment in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(appointment.clientName)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(appointment.service)
                                    .font(.caption.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.accentColor.opacity(0.15))
                                    .foregroundColor(.accentColor)
                                    .clipShape(Capsule())
                                
                                Text(appointment.date, style: .date)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .fill(AppTheme.nailHubCream)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(Color.black.opacity(0.05), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .background(AppTheme.nailHubBackground)
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Ιστορικό")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    HistoryAppointmentScreen()
}
