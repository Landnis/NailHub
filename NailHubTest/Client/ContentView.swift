//
//  ContentView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \AppointmentModel.date) private var appointments: [AppointmentModel]
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ExistingClientModel.clientName) private var employees: [ExistingClientModel]
    @State private var showAddForm = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if appointments.isEmpty {
                    ContentUnavailableView(
                        "Κανένα Ραντεβού",
                        systemImage: "calendar.badge.exclamationmark",
                        description: Text("Πατήστε το κουμπί για να ξεκινήσετε.")
                    )
                } else {
                    List {
                        ForEach(appointments) { appointment in
                            NavigationLink(destination: AppointmentDetailView(appointment: appointment)) {
                                VStack(alignment: .leading) {
                                    Text(appointment.clientName).font(.headline)
                                    Text(appointment.date, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                
                Button {
                    showAddForm = true
                } label: {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Ραντεβού")
            .navigationDestination(isPresented: $showAddForm) {
                AppointmentView()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(appointments[index])
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: AppointmentModel.self, inMemory: true)
}
