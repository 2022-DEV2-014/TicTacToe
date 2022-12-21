// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation

class GameBoard {
    typealias BoardPosition = (row: Int, col: Int)

    private let allWinningPositions = [
        //Horizontal
        [(row: 0, col: 0), (row: 0, col: 1), (row: 0, col: 2)],
        [(row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2)],
        [(row: 2, col: 0), (row: 2, col: 1), (row: 2, col: 2)],

        //Vertical
        [(row: 0, col: 0), (row: 1, col: 0), (row: 2, col: 0)],
        [(row: 0, col: 1), (row: 1, col: 1), (row: 2, col: 1)],
        [(row: 0, col: 2), (row: 1, col: 2), (row: 2, col: 2)],

        //Diagonal
        [(row: 0, col: 0), (row: 1, col: 1), (row: 2, col: 2)],
        [(row: 0, col: 2), (row: 1, col: 1), (row: 2, col: 0)]
    ]

    // For now let's consider the board as an array of optional players
    private(set) var board: [Player?] = .init(repeating: nil, count: 9)

    var isEmpty: Bool {
        board.filter { $0 != nil }.isEmpty
    }

    var isFull: Bool {
        board.filter { $0 == nil }.isEmpty
    }

    var winner: Player? {
        return allWinningPositions
            .compactMap(winner(at:))
            .first
    }

    func play(_ player: Player, on coordinate: BoardPosition) {
        let position = positionInArray(for: coordinate)

        guard board[position] == nil else {
            return
        }

        board[position] = player
    }


    private func winner(at position: [BoardPosition]) -> Player? {
        let movesInPosition = position
            .map(positionInArray)
            .compactMap { board[$0] }

        let firstPlayer = movesInPosition.first

        let movesOfPlayerInWinPosition = movesInPosition.filter { $0 == firstPlayer }

        guard movesOfPlayerInWinPosition.count == 3 else {
            return nil
        }

        return firstPlayer
    }

    private func positionInArray(for position: BoardPosition) -> Int {
        let width: Int = 3
        return width * position.row + position.col
    }

}
