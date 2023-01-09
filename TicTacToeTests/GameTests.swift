// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

final class GameTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()
        trackForMemoryLeaks(sut)

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_gameStateIsReady_whenNotStarted() {
        let sut = Game()
        trackForMemoryLeaks(sut)

        XCTAssertEqual(sut.currentState, .ready)
    }

    func test_gameStateIsOnGoing_whenStarted() {
        let sut = Game()
        trackForMemoryLeaks(sut)

        try? sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentState, .onGoing)
    }


    func test_playerToggles_afterEachPlay() {
        let sut = Game()
        trackForMemoryLeaks(sut)

        try? sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .o)

        try? sut.play(at: (row: 1, col: 0))

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_playerDoesNotToggle_afterAnAttemptToPlayOnAnAlreadyOccupiedPosition() {
        let sut = Game()
        trackForMemoryLeaks(sut)

        try? sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .o)

        try? sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .o)
    }

    func test_gameIsDraw_whenAllPlacesAreOccupiedAndTheresNoWinner() {
        let sut = Game(
            board: GameBoard(
                boardRepresentation:
            """
               x, x, o
               o, o, x,
               x, x, o
            """)
        )
        trackForMemoryLeaks(sut)

        XCTAssertEqual(sut.currentState, .draw)
    }

    func test_gameIsWonByX_whenXHasThreeInARow() {
        let sut = Game(
            board: GameBoard(
                boardRepresentation:
            """
               x, x, x
               _, o, o,
               _, _, _
            """)
        )
        trackForMemoryLeaks(sut)

        XCTAssertEqual(sut.currentState, .won(.x))
    }

    func test_gameIsWonByO_whenOHasThreeInARow() {
        let sut = Game(
            board: GameBoard(
                boardRepresentation:
            """
               x, x, o
               o, o, o,
               _, _, x
            """)
        )
        trackForMemoryLeaks(sut)

        XCTAssertEqual(sut.currentState, .won(.o))
    }

    func test_onceAGameIsWon_NoMoreMovesArePossible() {
        let sut = Game(
            board: GameBoard(
                boardRepresentation:
            """
               x, x, o
               o, o, o,
               _, _, x
            """)
        )
        trackForMemoryLeaks(sut)

        XCTAssertThrowsError(try sut.play(at: (row: 2, col: 0)), "If Game is Ended there is no movement possible")
    }
}
