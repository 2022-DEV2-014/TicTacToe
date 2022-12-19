// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest

class GameBoard {
    // For now let's consider the board as an array of optional players
    private var board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }

    func play(_ player: Player) {
        board.insert(player, at: 0)
    }

}

final class GameBoardTests: XCTestCase {

    func test_board_startsEmpty() {
        let sut = GameBoard()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheBoard() {
        let sut = GameBoard()

        sut.play(.x)

        XCTAssertFalse(sut.isEmpty)
    }

}
