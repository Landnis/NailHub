//
//  WelcomeScreen.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 2/5/26.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var showMainApp: Bool
    var body: some View {
        ZStack {
            // 1. Φόντο
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {

                Spacer()
                
                VStack(spacing: 8) {
                    Text("NAIL HUB")
                        .font(.system(size: 42, weight: .bold, design: .monospaced))
                        .tracking(5)
                        .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.4))
                    
                    Rectangle()
                        .frame(width: 80, height: 1)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    print("Start tapped!")
                    showMainApp = true
                }) {
                    Text("START")
                        .font(.headline)
                        .tracking(2)
                        .foregroundColor(.black)
                        .frame(width: 200, height: 50)
                        .background(AppTheme.nailHubCream)
                        .cornerRadius(25)
                }
                .padding(.bottom, 50)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            }
        }
    }
}

#Preview {
    WelcomeScreen(showMainApp: .constant(false))
}
