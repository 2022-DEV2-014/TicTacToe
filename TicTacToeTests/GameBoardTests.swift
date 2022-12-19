// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest

class GameBoard {
    // For now let's consider the board as an array of optional players
    private let board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }
}

final class GameBoardTests: XCTestCase {

    func test_board_startsEmpty() {
        let sut = GameBoard()

        XCTAssertTrue(sut.isEmpty)
    }

}
