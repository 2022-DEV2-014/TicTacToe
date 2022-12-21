// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

final class GameBoardTests: XCTestCase {

    func test_board_startsEmpty() {
        let sut = GameBoard()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheBoard() throws {
        let sut = GameBoard()

        try sut.play(.x, on: (row: 0, col: 1))

        XCTAssertFalse(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheRightPosition() throws {
        let sut = GameBoard()

        try sut.play(.x, on: (row: 1, col: 0))
        try sut.play(.o, on: (row: 1, col: 1))
        try sut.play(.x, on: (row: 1, col: 2))
        try sut.play(.o, on: (row: 2, col: 0))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x,  .o,  .x,
            .o, nil, nil
        ])
    }

    func test_aPlayersTurn_cantBePlacedInAnAlreadyUsedPosition() throws {
        let sut = GameBoard()

        try sut.play(.x, on: (row: 1, col: 0))

        XCTAssertThrowsError(try sut.play(.o, on: (row: 1, col: 0)), "A duplicated move should be detected")
        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x, nil, nil,
            nil, nil, nil
        ])
    }

    func test_anOngoingGame_hasNoWinner() {
        let sut = GameBoard(boardRepresentation:
        """
            x, o, x,
            _, _, _,
            _, _, _
        """)

        XCTAssertEqual(sut.winner, nil)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstRow() {
        let sut = GameBoard(boardRepresentation:
        """
            x, x, x,
            _, _, _,
            _, _, _
        """)

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleRow() {
        let sut = GameBoard(boardRepresentation:
        """
            _, _, _,
            x, x, x,
            _, _, _
        """)

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastRow() {
        let sut = GameBoard(boardRepresentation:
        """
            _, _, _,
            _, _, _,
            o, o, o
        """)

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstColumn() {
        let sut = GameBoard(boardRepresentation:
        """
            x, _, _,
            x, _, _,
            x, _, _
        """)

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleColumn() {
        let sut = GameBoard(boardRepresentation:
        """
            _, x, _,
            _, x, _,
            _, x, _
        """)

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastColumn() {
        let sut = GameBoard(boardRepresentation:
        """
            _, _, o,
            _, _, o,
            _, _, o
        """)

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtFirstPositionInTheBoard() {
        let sut = GameBoard(boardRepresentation:
        """
            o, _, _,
            _, o, _,
            _, _, o
        """)

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtLastColumnFirstRowInTheBoard() {
        let sut = GameBoard(boardRepresentation:
        """
            _, _, o,
            _, o, _,
            o, _, _
        """)

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aFullBoard_isAchievedWhenAllPlacesAreOccupied() {
        let sut = GameBoard(boardRepresentation:
        """
            o, x, x,
            x, o, o,
            x, o, x
        """)

        XCTAssertEqual(sut.winner, nil)
        XCTAssertTrue(sut.isFull)
    }

}
