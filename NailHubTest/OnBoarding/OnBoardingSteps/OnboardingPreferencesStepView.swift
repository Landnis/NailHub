//
//  OnboardingPreferencesStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingPreferencesStepView: View {
    var onNext: () -> Void
    
    @State private var selectedStyle: NailStyle? = nil
    
    var body: some View {
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                titleView
                
                stylesGrid
                
                Spacer()
                
                nextButton
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
                .foregroundColor(Color.white.opacity(0.9))
            
            Text("This helps us personalize suggestions")
                .font(.subheadline)
                .foregroundColor(.gray)
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
    
    var nextButton: some View {
        Button(action: {
            onNext()
        }) {
            Text("Continue")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(selectedStyle == nil ? Color.gray : AppTheme.nailHubStartBtn)
                .cornerRadius(16)
        }
        .disabled(selectedStyle == nil)
        .padding(.bottom, 30)
    }
}

#Preview {
    OnboardingPreferencesStepView(onNext: {})
}
