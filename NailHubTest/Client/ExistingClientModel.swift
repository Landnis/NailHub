//
//  ExistingClientModel 2.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 20/4/26.
//


import Foundation
import SwiftData

@Model
final class ExistingClientModel {
    var clientName: String
    var clientPhone: String
    
    init(clientName: String, clientPhone: String) {
        self.clientName = clientName
        self.clientPhone = clientPhone
    }
}
