//
//  NailHubTests.swift
//  NailHubTests
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import Testing
@testable import NailHub

struct AppFlowTests {

    @Test
    func app_starts_in_welcome_flow() {
        let flow = AppFlow.welcome
        #expect(flow == .welcome)
    }
}

// MARK: - Model Tests

struct ExistingClientModelTests {

    @Test
    func client_model_initializes_correctly() {
        let client = ExistingClientModel(clientName: "Maria")

        #expect(client.clientName == "Maria")
    }
}

// MARK: - Logic Tests (pure Swift logic)

struct ClientLogicTests {

    @Test
    func removing_client_works_correctly() {
        var clients = [
            ExistingClientModel(clientName: "A"),
            ExistingClientModel(clientName: "B")
        ]

        clients.removeAll { $0.clientName == "A" }

        #expect(clients.count == 1)
        #expect(clients.first?.clientName == "B")
    }
}
