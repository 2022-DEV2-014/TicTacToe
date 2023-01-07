// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import UIKit

class CompositionRoot {
    let game = ReseatableTicTacToe()

    func createView() -> UIViewController {
        let presenter = TicTacToePresenter(game: game)
        let view = TicTacToeViewController(presenter: presenter)
        presenter.display = view

        return view
    }
}

extension TicTacToeViewController: GameDisplay {
    func showError(message: String) {
        print(message)
    }

    func updateBoard(tokens: [String]) {
        tokens.enumerated().forEach { index, token in
            place(title: token, at: index)
        }
    }
}
