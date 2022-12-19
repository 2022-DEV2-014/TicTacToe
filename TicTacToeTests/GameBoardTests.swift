// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest

class GameBoard {
//    typealias Coordinates = (x: Int, y: Int)
    // For now let's consider the board as an array of optional players
    private(set) var board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }

    func play(_ player: Player, on coordinate: CGPoint) {
        let width: Int = 3
        let col = Int(coordinate.x)
        let row = Int(coordinate.y)

        let position = width * row + col

        board[position] = player
    }

}

final class GameBoardTests: XCTestCase {

    func test_board_startsEmpty() {
        let sut = GameBoard()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheBoard() {
        let sut = GameBoard()

        sut.play(.x, on: .init(x:0, y:1))

        XCTAssertFalse(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheRightPosition() {
        let sut = GameBoard()

        sut.play(.x, on: .init(x:0, y:1))
        sut.play(.o, on: .init(x:1, y:1))
        sut.play(.x, on: .init(x:2, y:1))
        sut.play(.o, on: .init(x:0, y:2))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,  //
             .x,  .o,  .x,
             .o, nil, nil
        ])
    }

}
