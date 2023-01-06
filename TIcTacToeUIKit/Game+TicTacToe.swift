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

    func play(at position: Int) throws {
        let stride = 3

        let row = position / stride
        let col = position % stride

        try play(at: (row: row, col: col))
    }
}

extension Game.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ready:
            return "Press one circle to start"
        case .onGoing:
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
