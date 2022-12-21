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
}

extension Game.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ready:
            return "Ready"
        case .onGoing:
            return "On Going"
        case .draw:
            return "Draw"
        case .won(let player):
            return "\(player) Won"
        }
    }
}

extension GameBoard {
    func player(at position: Position) -> String {
        guard let player = board[positionInArray(for: position)] else {
            return "-"
        }
        return "\(player)"
    }
}
