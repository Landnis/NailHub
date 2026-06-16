//
//  WelcomeScreen.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 2/5/26.
//

import SwiftUI

enum AppFlow {
    case welcome
    case onboarding
    case main
}

struct WelcomeScreen: View {
    @Binding var flow: AppFlow
    
    var body: some View {
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                mainContainerView
                
                Spacer()
                startBtnView
            }
        }
    }
}

extension WelcomeScreen {
    
    var mainContainerView: some View {
        VStack(spacing: 8) {
            Text("NAIL HUB")
                .font(.system(size: 42, weight: .bold, design: .monospaced))
                .tracking(5)
                .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.4))
            
            Rectangle()
                .frame(width: 80, height: 1)
                .foregroundColor(.gray)
        }
    }
    
    var startBtnView: some View {
        Button(action: {
            flow = .main
        }) {
            Text("START")
                .font(.headline)
                .tracking(2)
                .foregroundColor(.black)
                .frame(width: 200, height: 50)
                .background(AppTheme.nailHubStartBtn)
                .cornerRadius(18)
        }
        .padding(.bottom, 50)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    WelcomeScreen(flow: .constant(.main))
}
