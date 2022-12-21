// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest

class GameBoard {
    private let baseWinningPositions = [
        [(0,0), (0,1), (0,2)],
        [(1,0), (1,1), (1,2)],
        [(2,0), (2,1), (2,2)],
        [(0,0), (1,1), (2,2)],
        [(0,2), (1,1), (2,0)]
    ]

    // This will evaluate 2 duplicated conditions, evaluating diagonals 4 times. 
    private lazy var allWinningPositions: [[(Int, Int)]] = {
        baseWinningPositions
            .reduce([[(Int, Int)]]()) { partialResult, winPosition in
                return partialResult + [
                    winPosition.map { ($0.0, $0.1) }
                ] + [
                    winPosition.map { ($0.1, $0.0) }
                ]
            }
    }()

    private lazy var winningPositionsInPoint: [[(CGPoint)]] = {
        allWinningPositions
            .reduce([[CGPoint]]()) { partialResult, winPosition in
                return partialResult + [
                    winPosition.map { CGPoint(row: $0.0, col: $0.1) }
                ]
            }
    }()

    // For now let's consider the board as an array of optional players
    private(set) var board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }

    var winner: Player? {
        return winningPositionsInPoint
            .compactMap(winner(at:))
            .first
    }

    private func winner(at position: [CGPoint]) -> Player? {
        let movesInPosition = position
            .map(\.positionInArray)
            .compactMap { board[$0] }

        let firstPlayer = movesInPosition.first

        let movesOfPlayerInWinPosition = movesInPosition.filter { $0 == firstPlayer }

        guard movesOfPlayerInWinPosition.count == 3 else {
            return nil
        }

        return firstPlayer
    }

    func play(_ player: Player, on coordinate: CGPoint) {
        let position = coordinate.positionInArray

        guard board[position] == nil else {
            return
        }
        
        board[position] = player
    }
}

extension CGPoint {
    init(row: Int, col: Int) {
        self.init(x: col, y: row)
    }

    var positionInArray: Int {
        let width: Int = 3
        let col = Int(x)
        let row = Int(y)

        return width * row + col
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

        sut.play(.x, on: .init(row: 1, col: 0))
        sut.play(.o, on: .init(row: 1, col: 1))
        sut.play(.x, on: .init(row: 1, col: 2))
        sut.play(.o, on: .init(row: 2, col: 0))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x,  .o,  .x,
            .o, nil, nil
        ])
    }

    func test_aPlayersTurn_cantBePlacedInAnAlreadyUsedPosition() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 1, col: 0))
        sut.play(.o, on: .init(row: 1, col: 0))

        XCTAssertEqual(sut.board, [
            nil, nil, nil,
            .x, nil, nil,
            nil, nil, nil
        ])
    }

    func test_anOngoingGame_hasNoWinner() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 0, col: 0))
        sut.play(.o, on: .init(row: 0, col: 1))
        sut.play(.x, on: .init(row: 0, col: 2))

        XCTAssertEqual(sut.winner, nil)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstRow() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 0, col: 0))
        sut.play(.x, on: .init(row: 0, col: 1))
        sut.play(.x, on: .init(row: 0, col: 2))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleRow() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 1, col: 0))
        sut.play(.x, on: .init(row: 1, col: 1))
        sut.play(.x, on: .init(row: 1, col: 2))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastRow() {
        let sut = GameBoard()

        sut.play(.o, on: .init(row: 2, col: 0))
        sut.play(.o, on: .init(row: 2, col: 1))
        sut.play(.o, on: .init(row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInFirstColumn() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 0, col: 0))
        sut.play(.x, on: .init(row: 1, col: 0))
        sut.play(.x, on: .init(row: 2, col: 0))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInTheMiddleColumn() {
        let sut = GameBoard()

        sut.play(.x, on: .init(row: 0, col: 1))
        sut.play(.x, on: .init(row: 1, col: 1))
        sut.play(.x, on: .init(row: 2, col: 1))

        XCTAssertEqual(sut.winner, .x)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInLastColumn() {
        let sut = GameBoard()

        sut.play(.o, on: .init(row: 0, col: 2))
        sut.play(.o, on: .init(row: 1, col: 2))
        sut.play(.o, on: .init(row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtFirstPositionInTheBoard() {
        let sut = GameBoard()

        sut.play(.o, on: .init(row: 0, col: 0))
        sut.play(.o, on: .init(row: 1, col: 1))
        sut.play(.o, on: .init(row: 2, col: 2))

        XCTAssertEqual(sut.winner, .o)
    }

    func test_aGameEndsWithAWiner_whenAPlayerHas3TokensInDiagonalStartingAtLastColumnFirstRowInTheBoard() {
        let sut = GameBoard()

        sut.play(.o, on: .init(row: 0, col: 2))
        sut.play(.o, on: .init(row: 1, col: 1))
        sut.play(.o, on: .init(row: 2, col: 0))

        XCTAssertEqual(sut.winner, .o)
    }

}
