//
//  OnboardingPrimaryButton.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingPrimaryButton: View {
    var title: String
    var isDisabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(buttonTextColor)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(buttonBackground)
                .cornerRadius(16)
                .animation(.easeInOut(duration: 0.2), value: isDisabled)
        }
        .disabled(isDisabled)
    }
}

extension OnboardingPrimaryButton {
    
    private var buttonTextColor: Color {
        isDisabled
        ? AppTheme.textPrimary
        : AppTheme.buttonText
    }
    
    private var buttonBackground: Color {
        isDisabled
        ? AppTheme.glassStroke
        : AppTheme.buttonPrimary
    }
}

#Preview {
    OnboardingPrimaryButton(title: "", isDisabled: true, action: {})
}
