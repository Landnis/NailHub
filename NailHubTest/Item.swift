//
//  Item.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
