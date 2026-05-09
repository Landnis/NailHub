//
//  ContentView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(
        filter: #Predicate<AppointmentModel> { !$0.isCompleted },
        sort: \.date
    )
    private var appointments: [AppointmentModel]
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ExistingClientModel.clientName) private var employees: [ExistingClientModel]
    @State private var showAddForm = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                AppTheme.nailHubBackground
                    .ignoresSafeArea()
                
                if appointments.isEmpty {
                    emptyContentView
                } else {
                    clientListView
                }
                
                addAppointmentButton
            }
            .navigationTitle("Ραντεβού")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $showAddForm) {
                AppointmentView()
            }
        }
        .onAppear {
            deletePastAppointments()
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(appointments[index])
        }
    }
    
    private func deletePastAppointments() {
        let now = Date()
        
        for appointment in appointments {
            if appointment.date < now && !appointment.isCompleted {
                appointment.isCompleted = true
            }
        }
        
        try? modelContext.save()
    }
    
}

extension ContentView {
    
    var emptyContentView: some View {
        ContentUnavailableView(
            "Κανένα Ραντεβού",
            systemImage: "calendar.badge.exclamationmark",
            description: Text("Πατήστε το κουμπί για να ξεκινήσετε.")
        )
    }
    
    var clientListView: some View {
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
                .listRowBackground(AppTheme.nailHubCream)
            }
            .onDelete(perform: deleteItems)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .scrollContentBackground(.hidden)
    }
    
    var addAppointmentButton: some View {
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
        .shadow(radius: 4, x: 0, y: 4)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}



#Preview {
    ContentView()
        .modelContainer(for: AppointmentModel.self, inMemory: true)
}
