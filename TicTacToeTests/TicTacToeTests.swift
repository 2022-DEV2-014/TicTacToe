// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

class Game {
    enum State {
        case ready
    }

    let board = GameBoard()

    var currentPlayer: Player = .x
    var currentState: State = .ready
}

enum Player {
    case x, o
}

final class GameTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_gameStateIsReady_whenNotStarted() {
        let sut = Game()

        XCTAssertEqual(sut.currentState, .ready)
    }
}
