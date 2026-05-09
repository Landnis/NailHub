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
                detailsView
                callButton
            }
            .padding()
        }
        .navigationTitle("Στοιχεία Υπαλλήλου")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

extension ClientDetailView {
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.accentColor)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(client.clientName)
                        .font(.title.bold())
                }
            }
            
            DetailRow(icon: "phone.fill", title: "Τηλέφωνο", value: client.clientPhone)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
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
        }
        .shadow(radius: 4, x: 0, y: 4)
    }
    
    func callClient() {
        let telephone = "tel://\(client.clientPhone)"
        
        guard let url = URL(string: telephone) else { return }
        
        UIApplication.shared.open(url)
    }
}

#Preview {
    ClientDetailView(client: ExistingClientModel(
        clientName: "",
        clientPhone: "")
    )
}
