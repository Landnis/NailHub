//
//  ServiceCard.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct ServiceCard: View {
    let service: ServiceType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(service.title)
                .font(.headline)
                .foregroundColor(
                    isSelected
                    ? AppTheme.buttonText
                    : AppTheme.textPrimary
                )
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            isSelected
                            ? AppTheme.buttonPrimary
                            : .clear
                        )
                )
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            isSelected
                            ? AppTheme.buttonPrimary.opacity(0.4)
                            : AppTheme.glassStroke,
                            lineWidth: 2
                        )
                )
        }
        .buttonStyle(.plain)
        .shadow(
            color: isSelected
            ? AppTheme.buttonPrimary.opacity(0.25)
            : .clear,
            radius: 10,
            y: 4
        )
    }
}

#Preview {
    ServiceCard(service: .acrylic, isSelected: true, action: {})
}
