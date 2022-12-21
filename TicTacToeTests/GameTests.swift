// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

final class GameTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_gameStateIsReady_whenNotStarted() {
        let sut = Game()

        XCTAssertEqual(sut.currentState, .ready)
    }

    func test_gameStateIsOnGoing_whenStarted() {
        let sut = Game()

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentState, .onGoing)
    }

    func test_playerToggles_afterEachPlay() {
        let sut = Game()

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .o)

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .x)
    }


}
