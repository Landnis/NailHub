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
    @AppStorage("onboardingCompleted") var onboardingCompleted = false
    @State private var flow: AppFlow = .welcome

    init() {
        NotificationManager.shared.requestPermission()
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            AppointmentModel.self,
            ExistingClientModel.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    var body: some Scene {
        WindowGroup {
            rootView
                .modelContainer(sharedModelContainer)
                .onAppear {
                    flow = .welcome
                }
        }
    }
}

extension NailHubTestApp {
    
    @ViewBuilder
    var rootView: some View {
        switch flow {
        case .welcome:
            WelcomeScreen(flow: $flow)
            
        case .onboarding:
            OnBoardingFlowView(flow: $flow)
            
        case .main:
            MainTabView()
        }
    }
}
