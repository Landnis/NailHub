//
//  AppointmentRevealView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 29/6/26.
//

import SwiftUI

struct AppointmentRevealView: View {
    
    @State private var showClient = false
    @State private var showAppointment = false
    
    @State private var showName = false
    @State private var showService = false
    @State private var showTime = false
    
    @State private var expandDeck = false
    @State private var floating = false
    @State private var hasPlayed = false
    
    var body: some View {
        
        ZStack {
            
            // CLIENT (back card)
            clientCard
                .scaleEffect(expandDeck ? 0.94 : 0.90)
                .rotationEffect(.degrees(expandDeck ? -2 : 0))
                .offset(
                    y: showClient
                    ? (expandDeck ? 55 : -10)
                    : 120
                )
                .zIndex(1)
            
            // APPOINTMENT (front card)
            appointmentCard
                .scaleEffect(expandDeck ? 1 : 0.96)
                .rotationEffect(.degrees(expandDeck ? 2 : 0))
                .offset(
                    y: showAppointment
                    ? (expandDeck ? -55 : 10)
                    : 180
                )
                .offset(y: floating ? -2 : 2)
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 18,
                    y: 12
                )
                .zIndex(2)
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: floating
                )
        }
        .frame(height: 340)
        .onAppear {
            
            guard !hasPlayed else { return }
            hasPlayed = true
            
            playAnimation()
        }
    }
}

// MARK: - APPOINTMENT CARD
extension AppointmentRevealView {
    
    var appointmentCard: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            Text("New Appointment")
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)
            
            Divider()
                .opacity(0.3)
            
            infoRow(icon: "person.fill", text: showName ? "Maria" : "")
            
            infoRow(icon: "sparkles", text: showService ? "Gel Manicure" : "")
            
            infoRow(icon: "clock.fill", text: showTime ? "Today • 14:30" : "")
            
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(AppTheme.glassBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(AppTheme.glassStroke.opacity(0.7), lineWidth: 1)
                )
        )
        .shadow(color: .black.opacity(0.08), radius: 20, y: 10)
        .padding(.horizontal, 24)
    }
}

// MARK: - CLIENT CARD
extension AppointmentRevealView {
    
    var clientCard: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(AppTheme.buttonPrimary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Maria")
                        .font(.title2.bold())
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text("Client Profile")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            
            Divider()
                .opacity(0.3)
            
            Label("+30697 XXX XXXX", systemImage: "phone.fill")
                .foregroundColor(AppTheme.textPrimary)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(AppTheme.nailHubCream)
        )
        .shadow(color: .black.opacity(0.06), radius: 15, y: 8)
        .padding(.horizontal, 24)
    }
}

// MARK: - HELPERS
extension AppointmentRevealView {
    
    func infoRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppTheme.buttonPrimary)
                .frame(width: 24)
            
            Text(text)
                .foregroundColor(AppTheme.textPrimary)
            
            Spacer()
        }
    }
}

// MARK: - ANIMATION
extension AppointmentRevealView {
    
    func playAnimation() {
        
        // 1. Client appears
        withAnimation(.spring(response: 0.7, dampingFraction: 0.85)) {
            showClient = true
        }
        
        // 2. Appointment appears
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.85)) {
                showAppointment = true
            }
        }
        
        // 3. Text reveal sequence
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation { showName = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation { showService = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation { showTime = true }
        }
        
        // 4. Stack settles
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.78)) {
                expandDeck = true
            }
        }
        
        // 5. Floating subtle motion
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            floating = true
        }
    }
}

#Preview {
    AppointmentRevealView()
}
