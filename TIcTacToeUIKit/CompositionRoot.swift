// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import UIKit

class CompositionRoot {
    let game = ReseatableTicTacToe()

    func createView() -> UIViewController {
        let view = TicTacToeViewController()

        view.buttonTapped = { index in
            do {
                try self.game.play(at: index)
            } catch {
                print(error.localizedDescription)
            }
        }

        return view
    }
}
