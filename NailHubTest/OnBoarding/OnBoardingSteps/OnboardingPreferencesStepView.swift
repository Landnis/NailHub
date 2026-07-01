//
//  OnboardingPreferencesStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingPreferencesStepView: View {
    
    @Binding var selectedStyle: NailStyle?
    var onNext: () -> Void
    
    var body: some View {
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                titleView
                
                stylesGrid
                
                Spacer()
                
                OnboardingPrimaryButton(
                    title: "Continue",
                    isDisabled: selectedStyle == nil,
                    action: onNext
                )
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
    }
}

extension OnboardingPreferencesStepView {
    
    var titleView: some View {
        VStack(spacing: 10) {
            Text("What style do you like?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("This helps us personalize suggestions")
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
        }
    }
    
    var stylesGrid: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(NailStyle.allCases) { style in
                
                StyleCard(
                    style: style,
                    isSelected: selectedStyle == style
                ) {
                    selectedStyle = style
                }
            }
        }
    }
}

#Preview {
    OnboardingPreferencesStepView(selectedStyle: .constant(.bold), onNext: {})
}
