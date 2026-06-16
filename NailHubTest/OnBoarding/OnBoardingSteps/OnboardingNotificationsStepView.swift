//
//  OnboardingNotificationsStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingNotificationsStepView: View {
    var onNext: () -> Void
    
    @State private var enableReminders: Bool = true
    @State private var enableOffers: Bool = false
    @State private var enableBookingUpdates: Bool = true
    
    var body: some View {
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                titleView
                
                togglesSection
                
                Spacer()
                
                nextButton
            }
            .padding(.horizontal, 20)
        }
    }
}

extension OnboardingNotificationsStepView {
    
    var titleView: some View {
        VStack(spacing: 10) {
            Text("Enable notifications")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.9))
            
            Text("Stay updated with your appointments")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    var togglesSection: some View {
        VStack(spacing: 15) {
            
            ToggleRow(
                title: "Appointment reminders",
                isOn: $enableReminders
            )
            
            ToggleRow(
                title: "Offers & promotions",
                isOn: $enableOffers
            )
            
            ToggleRow(
                title: "Booking updates",
                isOn: $enableBookingUpdates
            )
        }
    }
    
    var nextButton: some View {
        Button(action: {
            onNext()
        }) {
            Text("Finish")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(AppTheme.nailHubStartBtn)
                .cornerRadius(16)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    OnboardingNotificationsStepView(onNext: {})
}
