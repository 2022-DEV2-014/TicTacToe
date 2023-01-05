// Created for TicTacToe in 2022
// Using Swift 5.0

import UIKit

class TicTacToeViewController: UIViewController {

    private(set) lazy var buttons: [UIButton] = createBoard()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func createBoard() -> [UIButton] {
        (1...9).map { index in
            let boardItem = UIButton()
            boardItem.tag = index
            return boardItem
        }
    }
}

