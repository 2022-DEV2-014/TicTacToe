// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation
import TicTacToe
import SwiftUI

class ObservableGame: ObservableObject {
    @Published private(set) var game: Game

    init() {
        self.game = .init()
    }

    init(game: Game = .init()) {
        self.game = game
    }

    func play(at position: GameBoard.Position) throws {
        try game.play(at: position)
        self.game = game
    }

    func translateToHumanReadable(error: Error) -> String {
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

extension GameBoard {
    func player(at position: Position) -> Player? {
        return board[positionInArray(for: position)]
    }
}

extension Player {
    var squareColor: Color {
        switch self {
        case .x: return .red
        case .o: return .green
        }
    }

    var token: String {
        switch self {
        case .x: return "X"
        case .o: return "O"
        }
    }
}

extension Game.ErrorState {
    var description: String {
        switch self {
        case .movementIsBlockedAsGameIsEnded:
            return "The game has ended, no new moves are allowed"
        }
    }
}

extension GameBoard.ErrorStates {
    var description: String {
        switch self {
        case .duplicatedMove:
            return "There's already a piece in this position"
        }
    }
}
