//
//  EmployeesListView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 20/4/26.
//

import SwiftUI
import SwiftData

struct ClientContainerView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \ExistingClientModel.clientName)
    private var employees: [ExistingClientModel]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                AppTheme.nailHubBackground
                    .ignoresSafeArea()
                if employees.isEmpty {
                    ContentUnavailableView(
                        "Δεν υπάρχουν εργαζόμενοι",
                        systemImage: "person.3.sequence",
                        description: Text("Πρόσθεσε το πρώτο μέλος της ομάδας σου για να ξεκινήσεις.")
                    )
                } else {
                    List {
                        ForEach(employees) { employee in
                            ClientDetailView(client: employee)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .listRowBackground(Color.clear)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        modelContext.delete(employee)
                                    } label: {
                                        Label("Διαγραφή", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .navigationTitle("Πελάτες")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
}

#Preview {
    ClientContainerView()
}
