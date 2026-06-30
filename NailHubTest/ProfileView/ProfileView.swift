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
                        appearanceSection
                        styleSection(profile)
                        servicesSection(profile)
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
        VStack(spacing: 12) {
            
            ZStack(alignment: .bottomTrailing) {
                
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
                    }
                }
                .buttonStyle(.plain)
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(AppTheme.profileIcon)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
            }
            
            VStack(spacing: 4) {
                Text(profile.name)
                    .font(.title2.bold())
                
                Text("Οι προτιμήσεις μου")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal)
    }
    
    // MARK: - APPEARANCE
    
    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Label("Εμφάνιση εφαρμογής", systemImage: "circle.lefthalf.filled")
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
            
            Text("Αλλαγή θέματος της εφαρμογής.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
    
    // MARK: - STYLE
    
    private func styleSection(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Label("Αγαπημένο στυλ", systemImage: "paintpalette")
                .font(.headline)
            
            Text(profile.selectedStyle?.title ?? "Δεν έχει επιλεγεί")
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(AppTheme.profileIcon.opacity(0.15))
                .clipShape(Capsule())
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.nailHubCream)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
    
    // MARK: - SERVICES
    
    private func servicesSection(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Label("Αγαπημένες υπηρεσίες", systemImage: "sparkles")
                .font(.headline)
            
            if profile.selectedServices.isEmpty {
                Text("Δεν υπάρχουν επιλεγμένες υπηρεσίες")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            } else {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 100), spacing: 10)],
                    spacing: 10
                ) {
                    ForEach(profile.selectedServices) { service in
                        Text(service.title)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(AppTheme.profileIcon.opacity(0.12))
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
}

#Preview {
    ProfileView()
}
