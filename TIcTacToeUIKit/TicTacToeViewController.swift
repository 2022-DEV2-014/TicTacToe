// Created for TicTacToe in 2022
// Using Swift 5.0

import UIKit

class TicTacToeViewController: UIViewController {

    private(set) lazy var buttons: [UIButton] = createBoard()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func createBoard() -> [UIButton] {
        Array(repeating: UIButton.init(), count: 9)
    }
}

