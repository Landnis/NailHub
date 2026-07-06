//
//  OnboardingServicesStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct OnboardingServicesStepView: View {
    var onNext: () -> Void
    
    @Binding var selectedServices: Set<ServiceType>
    
    var body: some View {
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                titleView
                
                servicesGrid
                
                Spacer()
                
                OnboardingPrimaryButton(
                    title: "Continue",
                    isDisabled: selectedServices.isEmpty,
                    action: onNext
                )
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
    }
}

extension OnboardingServicesStepView {
    
    var titleView: some View {
        VStack(spacing: 10) {
            Text("What services do you prefer?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("Select all that apply")
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
        }
    }
    
    var servicesGrid: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(ServiceType.allCases) { service in
                
                ServiceCard(
                    service: service,
                    isSelected: selectedServices.contains(service)
                ) {
                    toggle(service)
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
                .background(selectedServices.isEmpty ? Color.gray : AppTheme.nailHubStartBtn)
                .cornerRadius(16)
        }
        .disabled(selectedServices.isEmpty)
        .padding(.bottom, 30)
    }
    
    private func toggle(_ service: ServiceType) {
        if selectedServices.contains(service) {
            selectedServices.remove(service)
        } else {
            selectedServices.insert(service)
        }
    }
}

#Preview {
    OnboardingServicesStepView(onNext: {}, selectedServices: .constant([]))
}
