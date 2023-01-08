// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import TicTacToe

extension Game: TicTacToe {
    var status: String {
        currentState.description
    }

    var started: Bool {
        currentState != .ready
    }

    var boardRepresentation: [String] {
        board.board.map(\.?.token).compactMap { $0 ?? "" }
    }

    func play(at position: Int) throws {
        let stride = 3

        let row = position / stride
        let col = position % stride

        try play(at: (row: row, col: col))
    }
    
}

extension Game: TicTacToeErrorTranslator {
    func humanReadable(error: Error) -> String {
        if let error = error as? Game.ErrorState {
            return error.description
        }
        if let error = error as? GameBoard.ErrorStates {
            return error.description
        }
        return error.localizedDescription
    }
}

extension Game.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ready, .onGoing:
            return ""
        case .draw:
            return "It's a Draw"
        case .won(let player):
            return "\(player.token) has Won!"
        }
    }
}

private extension Player {
    var token: String {
        switch self {
        case .x: return "X"
        case .o: return "O"
        }
    }
}

private extension Game.ErrorState {
    var description: String {
        switch self {
        case .movementIsBlockedAsGameIsEnded:
            return "The game has ended, no new moves are allowed"
        }
    }
}

private extension GameBoard.ErrorStates {
    var description: String {
        switch self {
        case .duplicatedMove:
            return "There's already a piece in this position"
        case .invalidMove:
            return "Movement is not valid"
        }
    }
}
