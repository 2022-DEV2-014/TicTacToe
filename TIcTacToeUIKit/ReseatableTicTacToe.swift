// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import TicTacToe

class ReseatableTicTacToe: TicTacToe, Resetable, TicTacToeErrorTranslator {
    private var game = Game()

    func play(at position: Int) throws {
        try game.play(at: position)
    }

    var status: String {
        game.status
    }

    var started: Bool {
        game.started
    }

    func reset() {
        game = .init()
    }

    func humanReadable(error: Error) -> String {
        game.humanReadable(error: error)
    }
}
