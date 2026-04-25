//
//  NailHubTestApp.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import SwiftUI
import SwiftData

@main
struct NailHubTestApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            AppointmentModel.self,
            ExistingClientModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Εδώ προσθέτουμε τα TabViews
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
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
