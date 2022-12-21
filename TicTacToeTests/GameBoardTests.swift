// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

final class GameBoardTests: XCTestCase {

    func test_board_startsEmpty() {
        let sut = GameBoard()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheBoard() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 0, col: 1))

        XCTAssertFalse(sut.isEmpty)
    }

    func test_aPlayersTurn_isStoredInTheRightPosition() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 1, col: 0))
        sut.play(.o, on: (row: 1, col: 1))
        sut.play(.x, on: (row: 1, col: 2))
        sut.play(.o, on: (row: 2, col: 0))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x,  .o,  .x,
            .o, nil, nil
        ])
    }

    func test_aPlayersTurn_cantBePlacedInAnAlreadyUsedPosition() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 1, col: 0))
        sut.play(.o, on: (row: 1, col: 0))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x, nil, nil,
            nil, nil, nil
        ])
    }

    func test_anOngoingGame_hasNoWinner() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 0, col: 0))
        sut.play(.o, on: (row: 0, col: 1))
        sut.play(.x, on: (row: 0, col: 2))

        XCTAssertEqual(sut.winner, nil)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstRow() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 0, col: 0))
        sut.play(.x, on: (row: 0, col: 1))
        sut.play(.x, on: (row: 0, col: 2))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleRow() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 1, col: 0))
        sut.play(.x, on: (row: 1, col: 1))
        sut.play(.x, on: (row: 1, col: 2))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastRow() {
        let sut = GameBoard()

        sut.play(.o, on: (row: 2, col: 0))
        sut.play(.o, on: (row: 2, col: 1))
        sut.play(.o, on: (row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstColumn() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 0, col: 0))
        sut.play(.x, on: (row: 1, col: 0))
        sut.play(.x, on: (row: 2, col: 0))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleColumn() {
        let sut = GameBoard()

        sut.play(.x, on: (row: 0, col: 1))
        sut.play(.x, on: (row: 1, col: 1))
        sut.play(.x, on: (row: 2, col: 1))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastColumn() {
        let sut = GameBoard()

        sut.play(.o, on: (row: 0, col: 2))
        sut.play(.o, on: (row: 1, col: 2))
        sut.play(.o, on: (row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtFirstPositionInTheBoard() {
        let sut = GameBoard()

        sut.play(.o, on: (row: 0, col: 0))
        sut.play(.o, on: (row: 1, col: 1))
        sut.play(.o, on: (row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtLastColumnFirstRowInTheBoard() {
        let sut = GameBoard()

        sut.play(.o, on: (row: 0, col: 2))
        sut.play(.o, on: (row: 1, col: 1))
        sut.play(.o, on: (row: 2, col: 0))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aFullBoard_isAchievedWhenAllPlacesAreOccupied() {
        let sut = GameBoard()

        sut.play(.o, on: (row: 0, col: 0))
        sut.play(.x, on: (row: 0, col: 1))
        sut.play(.x, on: (row: 0, col: 2))

        sut.play(.x, on: (row: 1, col: 0))
        sut.play(.o, on: (row: 1, col: 1))
        sut.play(.o, on: (row: 1, col: 2))

        sut.play(.x, on: (row: 2, col: 0))
        sut.play(.o, on: (row: 2, col: 1))
        sut.play(.x, on: (row: 2, col: 2))

        XCTAssertEqual(sut.winner, nil)
        XCTAssertTrue(sut.isFull)
    }

}
