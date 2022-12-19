// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

class Game {
    enum Player {
        case x, o
    }
    var currentPlayer: Player = .x
}

final class TicTacToeTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let game = Game()

        XCTAssertEqual(game.currentPlayer, .x)
    }

}
