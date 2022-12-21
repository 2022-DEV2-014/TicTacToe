// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation
import TicTacToe

class ObservableGame: ObservableObject {
    @Published private(set) var game: Game

    init(game: Game) {
        self.game = game
    }

    func play(at position: GameBoard.Position) throws {
        try game.play(at: position)
    }
}
