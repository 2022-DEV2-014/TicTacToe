// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TicTacToe

final class GameTests: XCTestCase {

    func test_playerX_alwaysGoesFirst() {
        let sut = Game()

        XCTAssertEqual(sut.currentPlayer, .x)
    }

    func test_gameStateIsReady_whenNotStarted() {
        let sut = Game()

        XCTAssertEqual(sut.currentState, .ready)
    }

    func test_gameStateIsOnGoing_whenStarted() {
        let sut = Game()

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentState, .onGoing)
    }

    func test_playerToggles_afterEachPlay() {
        let sut = Game()

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .o)

        sut.play(at: (row: 0, col: 0))

        XCTAssertEqual(sut.currentPlayer, .x)
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

        XCTAssertEqual(sut.currentState, .won(.o))
    }
}


extension GameBoard {
    convenience init(boardRepresentation: String) {
        self.init()

        let positions: [Player?] = boardRepresentation
            .lowercased()
            .filter { $0 == "x" || $0 == "o" || $0 == "_" }
            .map {
                if $0 == "x" {
                    return .x
                }
                if $0 == "o" {
                    return .o
                }
                return nil
            }


        positions
            .enumerated()
            .forEach { (index, item) in
                guard let player = item else {
                    return
                }
                forceInsert(player: player, at: index)
            }
    }
}
