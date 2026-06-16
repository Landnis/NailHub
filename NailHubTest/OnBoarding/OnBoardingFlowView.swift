//
//  OnBoardingFlowView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnBoardingFlowView: View {
    @Binding var flow: AppFlow
    @AppStorage("onboardingCompleted") var onboardingCompleted = false
    
    @State private var step: Int = 0
    var body: some View {
        switch step {
            case 0:
                OnboardingNameStepView(onNext: { step += 1 })
            case 1:
                OnboardingServicesStepView(onNext: { step += 1 })
            case 2:
                OnboardingPreferencesStepView(onNext: { step += 1 })
            case 3:
                OnboardingNotificationsStepView(onNext: {
                    completeOnboarding()
                })
            default:
                EmptyView()
            }
    }
    
    func completeOnboarding() {
        onboardingCompleted = true
        flow = .main
    }
}

#Preview {
    OnBoardingFlowView(flow: .constant(.onboarding))
}
