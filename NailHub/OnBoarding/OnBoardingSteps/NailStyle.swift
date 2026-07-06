//
//  NailStyle.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import Foundation

enum NailStyle: String, CaseIterable, Identifiable, Codable {
    case natural
    case bold
    case nailArt
    case minimal
    case luxury

    var id: String { rawValue }

    var title: String {
        switch self {
        case .natural: return "Natural"
        case .bold: return "Bold"
        case .nailArt: return "Nail Art"
        case .minimal: return "Minimal"
        case .luxury: return "Luxury"
        }
    }
}
