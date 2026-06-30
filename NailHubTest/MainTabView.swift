//
//  MainTabView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 2/5/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Ραντεβού", systemImage: "calendar")
                }
            
            ClientContainerView()
                .tabItem {
                    Label("Πελάτες", systemImage: "person.2")
                }
            
            HistoryAppointmentScreen()
                .tabItem {
                    Label("Ιστορικό", systemImage: "clock.arrow.circlepath")
                }
            ProfileView()
                .tabItem {
                    Label("Προφίλ", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
