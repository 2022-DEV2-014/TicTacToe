// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

class Game {
    enum Player {
        case x, o
    }

    // For now let's consider the board as an array of optional players
    var board: [Player?] = .init(repeating: nil, count: 9)

    var currentPlayer: Player = .x
}

final class TicTacToeTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_board_startsEmpty() {
        let sut = Game()

        XCTAssertTrue(sut.board.compactMap { $0 }.isEmpty)
    }

}
