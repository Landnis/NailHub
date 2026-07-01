//
//  ServiceType.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/6/26.
//

import Foundation

enum ServiceType: String, CaseIterable, Identifiable, Codable {
    case manicure
    case pedicure
    case gel
    case acrylic
    case nailArt
    case refill
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .manicure: return "Manicure"
        case .pedicure: return "Pedicure"
        case .gel: return "Gel Nails"
        case .acrylic: return "Acrylic"
        case .nailArt: return "Nail Art"
        case .refill: return "Refill"
        }
    }
}
