//
//  AppTheme.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 25/4/26.
//

import SwiftUI

struct AppTheme {
    static let nailHubBackground = LinearGradient(
        colors: [
            Color("nudeTop"),
            Color("nudeMid"),
            Color("nudeBottom")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    static let profileIcon = Color("profileIcon")
    static let textPrimary = Color("textPrimary")
    static let textSecondary = Color("textSecondary")
    static let textSoft = Color("textSoft")
    
    static let glassBackground = Color("glassBackground")
    static let glassStroke = Color("glassStroke")
    
    static let buttonPrimary = Color("buttonPrimary")
    static let buttonText = Color("buttonText")

    static let nailHubCream = Color("nailHubCream")
    static let nailHubSoftGray = Color("nailHubSoftGray")
    static let nailHubStartBtn = Color("nailHubStartBtnColor")
    static let nailHubBtnText = Color("nailHubMainButtonTextColor")
}
