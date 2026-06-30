//
//  OnboardingModel.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 29/6/26.
//

import Foundation
import SwiftData

struct OnboardingModel {
    var name: String = ""
    var selectedServices: Set<ServiceType> = []
    var selectedStyle: NailStyle? = nil
    var profileImageData: Data? = nil
}

