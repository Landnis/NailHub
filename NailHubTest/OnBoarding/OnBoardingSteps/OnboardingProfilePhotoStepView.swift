//
//  OnboardingProfilePhotoStepView.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import SwiftUI
import PhotosUI

struct OnboardingProfilePhotoStepView: View {
    var onNext: () -> Void
    @Binding var profileImageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: UIImage?
    
    var body: some View {
        
        ZStack {
            AppTheme.nailHubBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                titleView
                
                profilePhotoView
                
                addPhotoButton
                
                Spacer()
                
                actionButtons
            }
            .padding(.horizontal, 24)
        }
        .task(id: selectedItem) {
            await loadSelectedImage()
        }
    }
}

// MARK: - Components

extension OnboardingProfilePhotoStepView {
    
    var titleView: some View {
        VStack(spacing: 10) {
            
            Text("Add a profile photo")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("Help your nail artist recognize you and personalize your experience")
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    var profilePhotoView: some View {
        ZStack {
            
            Circle()
                .fill(AppTheme.glassBackground)
                .frame(width: 140, height: 140)
                .overlay {
                    Circle()
                        .stroke(AppTheme.glassStroke, lineWidth: 1)
                }
            
            if let profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
    
    var addPhotoButton: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images
        ) {
            Text(profileImage == nil ? "Choose Photo" : "Change Photo")
                .font(.headline)
                .foregroundColor(AppTheme.buttonPrimary)
        }
    }
    
    var actionButtons: some View {
        VStack(spacing: 12) {
            
            OnboardingPrimaryButton(
                title: profileImage == nil ? "Add Photo" : "Continue",
                isDisabled: profileImage == nil,
                action: {
                    onNext()
                }
            )
            
            Button("Skip for now") {
                onNext()
            }
            .foregroundColor(AppTheme.textSecondary)
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Helpers

extension OnboardingProfilePhotoStepView {
    
    private func loadSelectedImage() async {
        
        guard let selectedItem else { return }
        
        do {
            if let data = try await selectedItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                profileImage = image
                profileImageData = data
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    OnboardingProfilePhotoStepView(onNext: {}, profileImageData: .constant(Data()))
}
