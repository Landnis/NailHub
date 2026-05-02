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
    
    @State private var showMainApp = false
    
    var body: some Scene {
        WindowGroup {
            if showMainApp {
                MainTabView()
            } else {
                WelcomeScreen(showMainApp: $showMainApp)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
