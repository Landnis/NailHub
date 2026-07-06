//
//  WelcomeScreen.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 2/5/26.
//

import SwiftUI

enum AppFlow {
    case welcome
    case onboarding
    case main
}

struct WelcomeScreen: View {
    
    @AppStorage("onboardingCompleted") private var onboardingCompleted = false
    @Binding var flow: AppFlow
    
    var body: some View {
        
        ZStack {
            
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                
                Spacer()
                
                mainContainerView
                
                AppointmentRevealView()
                    .frame(height: 260)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                startBtnView
            }
        }
    }
}

extension WelcomeScreen {

    var mainContainerView: some View {

        VStack(spacing: 12) {

            Text("NAIL HUB")
                .font(.system(size: 42,
                              weight: .bold,
                              design: .rounded))
                .tracking(6)
                .foregroundColor(AppTheme.textPrimary)

            Text("Smart appointment management")
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)

            RoundedRectangle(cornerRadius: 2)
                .fill(AppTheme.buttonPrimary.opacity(0.35))
                .frame(width: 70, height: 3)
        }
    }
}

extension WelcomeScreen {
    var startBtnView: some View {
        
        OnboardingPrimaryButton(
            title: "Get Started",
            isDisabled: false
        ) {
            if onboardingCompleted {
                flow = .main
            } else {
                flow = .onboarding
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
    }
}

#Preview {
    WelcomeScreen(flow: .constant(.main))
}
