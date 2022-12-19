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

class GameBoard {
    // For now let's consider the board as an array of optional players
    private let board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }
}

final class TicTacToeTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_board_startsEmpty() {
        let sut = Game()

        XCTAssertTrue(sut.board.isEmpty)
    }

}
