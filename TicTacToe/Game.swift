// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation

class Game {
    enum State {
        case ready
        case onGoing
        case draw
    }

    private let board: GameBoard
    private(set) var currentPlayer: Player = .x
    var currentState: State {
        if board.isEmpty {
            return .ready
        }

        if board.isFull && board.winner == nil {
            return .draw
        }
        return .onGoing
    }


    init(board: GameBoard = .init()) {
        self.board = board
    }

    func play(at position: GameBoard.Position) {
        board.play(currentPlayer, on: position)
        currentPlayer = currentPlayer == .x ? .o : .x
    }
}
