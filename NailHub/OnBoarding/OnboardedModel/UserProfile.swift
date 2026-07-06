//
//  UserProfile.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 29/6/26.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI

@Model
final class UserProfile {
    var id: UUID = UUID()

    var name: String

    var selectedServices: [ServiceType]
    var selectedStyle: NailStyle?
    var appearanceRaw: String

    var profileImageData: Data?

    init(
        name: String,
        selectedServices: [ServiceType] = [],
        selectedStyle: NailStyle? = nil,
        appearance: ThemePreference = .light,
        profileImageData: Data? = nil
    ) {
        self.name = name
        self.selectedServices = selectedServices
        self.selectedStyle = selectedStyle
        self.appearanceRaw = appearance.rawValue
        self.profileImageData = profileImageData
    }
}

enum ThemePreference: String, CaseIterable {
    case light = "light"
    case dark = "dark"
    case system = "system"

    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "circle.lefthalf.filled"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}

extension UserProfile {

    var appearance: ThemePreference {
        get {
            ThemePreference(rawValue: appearanceRaw) ?? .system
        }
        set {
            appearanceRaw = newValue.rawValue
        }
    }
}
