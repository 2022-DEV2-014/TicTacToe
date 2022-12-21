// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation
import TicTacToe
import SwiftUI

enum Token: String {
    case x = "X"
    case o = "O"
    case none = ""

    init?(player: Player?) {
        guard let player else {
            self = .none
            return
        }
        self = Token(rawValue: player.token) ?? .none
    }
}

class ObservableGame: ObservableObject {
    private var game: Game
    @Published var board: [Token] = []

    init() {
        self.game = .init()
        board = game.board.board.compactMap(Token.init)
    }

    func play(at position: GameBoard.Position) throws {
        try game.play(at: position)

        board = game.board.board.compactMap(Token.init)
    }

    func token(at position: GameBoard.Position) -> Token {
        let index = 3 * position.row + position.col
        return board[index]
    }

    var status: String {
        game.currentState.description
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

extension Token {
    var squareColor: Color {
        switch self {
        case .x: return .red
        case .o: return .green
        case .none: return .blue
        }
    }
}

extension Player {
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
