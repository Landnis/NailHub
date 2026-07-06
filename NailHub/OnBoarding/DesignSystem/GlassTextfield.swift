//
//  GlassTextfield.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI

struct GlassTextfield: View {
    
    var placeholder: String
    @Binding var text: String
    
    var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .tint(AppTheme.nailHubStartBtn)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.glassBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused
                            ? AppTheme.nailHubStartBtn
                            : AppTheme.glassStroke,
                            lineWidth: 1)
            )
    }
}

#Preview {
    GlassTextfield(placeholder: "", text: .constant(""), isFocused: true)
}
