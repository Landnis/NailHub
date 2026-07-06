//
//  NailHubUITests.swift
//  NailHubUITests
//
//  Created by Konstantinos Stergiannis on 18/4/26.
//

import XCTest

final class NailHubUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // MARK: - Launch + Welcome

    @MainActor
    func test_app_launch_shows_welcome_screen() {
        let app = XCUIApplication()
        app.launchArguments = ["UI-Testing"]
        app.launch()

        let welcome = app.otherElements["WelcomeScreen"]

        XCTAssertTrue(welcome.waitForExistence(timeout: 5))
    }

    // MARK: - App state

    @MainActor
    func test_app_stays_in_foreground() {
        let app = XCUIApplication()
        app.launchArguments = ["UI-Testing"]
        app.launch()

        XCTAssertEqual(app.state, .runningForeground)
    }

    // MARK: - Clients screen

    @MainActor
    func test_client_screen_opens() {
        let app = XCUIApplication()
        app.launchArguments = ["UI-Testing"]
        app.launch()

        let screen = app.otherElements["ClientContainerView"]

        XCTAssertTrue(screen.waitForExistence(timeout: 5))
    }

    // MARK: - Empty state

    @MainActor
    func test_empty_state_shows_message() {
        let app = XCUIApplication()
        app.launchArguments = ["UI-Testing", "EMPTY"]
        app.launch()

        XCTAssertTrue(
            app.staticTexts["Δεν υπάρχουν εργαζόμενοι"]
                .waitForExistence(timeout: 5)
        )
    }

    // MARK: - Data state

    @MainActor
    func test_list_state_shows_clients() {
        let app = XCUIApplication()
        app.launchArguments = ["UI-Testing", "HAS_DATA"]
        app.launch()

        XCTAssertTrue(app.tables.firstMatch.waitForExistence(timeout: 5))
    }
}
