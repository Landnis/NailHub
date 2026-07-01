//
//  OnboardingNameStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingNameStepView: View {
    @FocusState private var isFocused: Bool
    @Binding var name: String
    
    var onNext: () -> Void
    
    var body: some View {
        
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                titleView
                
                GlassTextfield(
                    placeholder: "Enter your name",
                    text: $name,
                    isFocused: isFocused
                )
                .padding(.horizontal, 4)
                
                Spacer()
                
                OnboardingPrimaryButton(
                    title: "Continue",
                    isDisabled: name.isEmpty,
                    action: onNext
                )
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - UI Components
extension OnboardingNameStepView {
    
    var titleView: some View {
        VStack(spacing: 10) {
            Text("What's your name?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("We'll use this to personalize your experience")
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    var textFieldView: some View {
        TextField("Enter your name", text: $name)
            .padding()
            .background(AppTheme.glassBackground)
            .cornerRadius(12)
            .foregroundColor(AppTheme.textPrimary)
            .autocapitalization(.words)
    }
}

extension OnboardingNameStepView {
    
    private var textColor: Color {
        name.isEmpty
        ? AppTheme.textSoft
        : AppTheme.buttonText
    }
    
    private var buttonBackground: some View {
        Group {
            if name.isEmpty {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.glassStroke, lineWidth: 1)
                    )
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.buttonPrimary)
            }
        }
    }
}
#Preview {
    OnboardingNameStepView(name: .constant("Kalliopi"), onNext: {})
}
