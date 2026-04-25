//
//  EmployeesDetails.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 19/4/26.
//

import SwiftUI
import SwiftData

struct ClientDetailView: View {
    let client: ExistingClientModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    // Header
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.accentColor)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(client.clientName)
                                .font(.title.bold())
                        }
                    }
                    
                    Divider()
                    
                    // Details
                    DetailRow(icon: "phone.fill", title: "Τηλέφωνο", value: client.clientPhone)
                }
                .padding()
                .background(AppTheme.nailHubCream)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                Button(action: {
                    let telephone = "tel://" + client.clientPhone
                    if let url = URL(string: telephone) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Label("Κλήση Υπαλλήλου", systemImage: "phone.arrow.up.right")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("Στοιχεία Υπαλλήλου")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ClientDetailView(client: ExistingClientModel(
        clientName: "",
        clientPhone: "")
    )
}
