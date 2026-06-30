//
//  ProfileView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 30/6/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ProfileView: View {
    
    @Query private var profiles: [UserProfile]
    private var profile: UserProfile? { profiles.first }
    
    @State private var selectedItem: PhotosPickerItem?
    @AppStorage("themePreference") private var themePreferenceRaw = ThemePreference.system.rawValue
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                AppTheme.nailHubBackground
                    .ignoresSafeArea()
                
                content
            }
            .navigationTitle("Προφίλ")
        }
    }
    
    // MARK: - CONTENT
    
    private var content: some View {
        Group {
            if let profile {
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        header(profile)
                        modernStats(profile)
                        appearanceSection
                        services(profile)
                        style(profile)
                    }
                    .padding(.vertical)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        guard let item = newItem,
                              let data = try? await item.loadTransferable(type: Data.self) else { return }
                        
                        profile.profileImageData = data
                    }
                }
                
            } else {
                ContentUnavailableView(
                    "Δεν υπάρχει προφίλ",
                    systemImage: "person.crop.circle.badge.exclamationmark"
                )
            }
        }
    }
    
    // MARK: - HEADER
    
    private func header(_ profile: UserProfile) -> some View {
        VStack(spacing: 14) {
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                
                ZStack {
                    
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 140, height: 140)
                    
                    if let data = profile.profileImageData,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "pencil.circle.fill")
                                .font(.title3)
                                .foregroundStyle(.white, AppTheme.profileIcon)
                                .shadow(radius: 3)
                        }
                        Spacer()
                    }
                    .frame(width: 140, height: 140)
                }
            }
            .buttonStyle(.plain)
            
            Text(profile.name)
                .font(.title2.bold())
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal)
    }
    
    // MARK: - STATS
    
    private func modernStats(_ profile: UserProfile) -> some View {
        HStack(spacing: 12) {
            
            statCard(
                title: "Αγαπημένες Υπηρεσίες",
                value: "\(profile.selectedServices.count)",
                icon: "sparkles"
            )
            
            statCard(
                title: "Στυλ",
                value: profile.selectedStyle?.title ?? "-",
                icon: "paintpalette"
            )
        }
        .padding(.horizontal)
    }
    
    private func statCard(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(AppTheme.profileIcon)
                Spacer()
            }
            
            Text(value)
                .font(.headline)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // MARK: - APPEARANCE
    
    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Εμφάνιση")
                .font(.headline)
            
            Picker("Appearance", selection: Binding(
                get: {
                    ThemePreference(rawValue: themePreferenceRaw) ?? .system
                },
                set: { newValue in
                    themePreferenceRaw = newValue.rawValue
                }
            )) {
                ForEach(ThemePreference.allCases, id: \.self) { preference in
                    Label {
                        Text(preference.displayName)
                    } icon: {
                        Image(systemName: preference.icon)
                    }
                    .tag(preference)
                }
            }
            .pickerStyle(.menu)
            .tint(AppTheme.profileIcon)
            
            Text("Αλλαγή εμφάνισης της εφαρμογής.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
    
    // MARK: - SERVICES
    
    private func services(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Υπηρεσίες")
                .font(.headline)
            
            if profile.selectedServices.isEmpty {
                Text("Δεν υπάρχουν υπηρεσίες")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            } else {
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 90), spacing: 8)
                    ],
                    spacing: 8
                ) {
                    ForEach(profile.selectedServices) { service in
                        Text(service.title)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
    
    // MARK: - STYLE
    
    private func style(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Στυλ")
                .font(.headline)
            
            Text(profile.selectedStyle?.title ?? "Δεν έχει επιλεγεί")
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
