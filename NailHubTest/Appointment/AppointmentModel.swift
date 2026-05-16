//
//  Item.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import Foundation
import SwiftData

@Model
final class AppointmentModel {
    var id: UUID
    var date: Date
    var clientName: String
    var service: String
    var clientPhone: String
    var notes: String
    var isCompleted: Bool = false
    
    init(timestamp: Date, clientName: String, service: String, clientPhone: String, notes: String) {
        self.id = UUID()
        self.date = timestamp
        self.clientName = clientName
        self.service = service
        self.clientPhone = clientPhone
        self.notes = notes
    }
}
