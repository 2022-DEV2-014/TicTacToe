// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation

class TicTacToePresenter {
    private let game: TicTacToe & Resetable & TicTacToeErrorTranslator
    weak var display: GameDisplay?

    init(game: TicTacToe & Resetable & TicTacToeErrorTranslator) {
        self.game = game
    }

    func userPlayedAt(position: Int) {
        do {
            try game.play(at: position)
            display?.updateBoard(tokens: game.boardRepresentation)
        } catch {
            let description = game.humanReadable(error: error)
            display?.showError(message: description)
        }
    }

    func userRequestedReset() {
        game.reset()
        display?.updateBoard(tokens: game.boardRepresentation)
    }

}
