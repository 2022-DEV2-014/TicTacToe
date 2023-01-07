// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import UIKit

extension TicTacToeViewController: GameDisplay {
    func displayState(message: String) {
        print(message)
    }

    func showError(message: String) {
        let dialogMessage = UIAlertController(
            title: "Tic Tac Toe",
            message: message,
            preferredStyle: .alert
        )

        let ok = UIAlertAction(title: "OK", style: .default)

        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }

    func updateBoard(tokens: [String]) {
        tokens.enumerated().forEach { index, token in
            place(title: token, at: index)
        }
    }
}
