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
        List {
            if completedAppointments.isEmpty {
                ContentUnavailableView(
                    "Κενό Ιστορικό",
                    systemImage: "clock.arrow.circlepath",
                    description: Text("Δεν υπάρχουν ολοκληρωμένα ραντεβού.")
                )
                .listRowBackground(Color.clear)
            } else {
                ForEach(completedAppointments) { appointment in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(appointment.clientName)
                            .font(.headline)
                        
                        Text(appointment.service)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(appointment.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .background(AppTheme.nailHubBackground)
        .scrollContentBackground(.hidden)
        .navigationTitle("Ιστορικό")
        .listStyle(.plain)
    }
}

#Preview {
    HistoryAppointmentScreen()
}
