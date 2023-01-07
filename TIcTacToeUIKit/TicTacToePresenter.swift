// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation

class TicTacToePresenter {
    private let game: TicTacToe & Resetable & TicTacToeErrorTranslator
    weak var alertDisplayer: AlertDisplayer?

    init(game: TicTacToe & Resetable & TicTacToeErrorTranslator) {
        self.game = game
    }

    func userPlayedAt(position: Int) {
        do {
            try game.play(at: position)
        } catch {
            let description = game.humanReadable(error: error)
            alertDisplayer?.displayError(message: description)
        }
    }

    func userRequestedReset() {
        game.reset()
    }

}
