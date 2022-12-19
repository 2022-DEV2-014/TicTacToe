// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

class Game {
    let board = GameBoard()

    var currentPlayer: Player = .x
}

enum Player {
    case x, o
}

final class GameTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }
}
