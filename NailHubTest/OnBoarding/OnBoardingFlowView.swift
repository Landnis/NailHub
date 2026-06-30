//
//  OnBoardingFlowView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI
import SwiftData

struct OnBoardingFlowView: View {
    @Binding var flow: AppFlow
    @AppStorage("onboardingCompleted") var onboardingCompleted = false
    @State private var model = OnboardingModel()
    @State private var step: Int = 0
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        switch step {
        case 0:
            OnboardingNameStepView(
                name: $model.name,
                onNext: { step += 1 }
            )
        case 1:
            OnboardingServicesStepView(
                onNext: { step += 1 },
                selectedServices: $model.selectedServices
            )
        case 2:
            OnboardingPreferencesStepView(
                selectedStyle: $model.selectedStyle,
                onNext: { step += 1 }
            )
        case 3:
            OnboardingProfilePhotoStepView(
                onNext: {
                    completeOnboarding()
                },
                profileImageData: $model.profileImageData
            )
        default:
            EmptyView()
        }
    }
    
    func completeOnboarding() {
        let profile = UserProfile(
            name: model.name,
            selectedServices: Array(model.selectedServices),
            selectedStyle: model.selectedStyle,
            appearance: .system,
            profileImageData: model.profileImageData
        )

        modelContext.insert(profile)

        do {
            try modelContext.save()
            print("✅ Profile saved")
        } catch {
            print("❌ Save failed:", error)
        }
        
        onboardingCompleted = true
        flow = .main
    }
}

#Preview {
    OnBoardingFlowView(flow: .constant(.onboarding))
}
