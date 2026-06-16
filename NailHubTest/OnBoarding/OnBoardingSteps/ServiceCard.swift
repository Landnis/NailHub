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
                .foregroundColor(isSelected ? .black : .white)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(isSelected ? AppTheme.nailHubStartBtn : Color.white.opacity(0.08))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.clear : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

#Preview {
    ServiceCard(service: .acrylic, isSelected: true, action: {})
}
