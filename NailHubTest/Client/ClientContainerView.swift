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
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            List {
                if employees.isEmpty {
                    Text("No employees found")
                        .foregroundColor(.secondary)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(employees) { employee in
                        ClientDetailView(client: employee)
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
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(employees[index])
        }
    }
    
}

#Preview {
    ClientContainerView()
}
