// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation

class Game {
    enum State: Equatable {
        case ready
        case onGoing
        case draw
        case won(Player)

        var isEnded: Bool {
            switch self {
            case .won(_), .draw:
                return true
            case .ready, .onGoing:
                return false
            }
        }
    }

    enum ErrorState: Error {
        case movementIsBlockedAsGameIsEnded
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

        if let winner = board.winner {
            return .won(winner)
        }
        return .onGoing
    }


    init(board: GameBoard = .init()) {
        self.board = board
    }

    func play(at position: GameBoard.Position) throws {
        guard !currentState.isEnded else {
            throw ErrorState.movementIsBlockedAsGameIsEnded
        }
        try board.play(currentPlayer, on: position)
        currentPlayer = currentPlayer == .x ? .o : .x
    }
}
