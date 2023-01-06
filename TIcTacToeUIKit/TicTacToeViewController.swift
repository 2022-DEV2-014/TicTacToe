// Created for TicTacToe in 2022
// Using Swift 5.0

import UIKit

class TicTacToeViewController: UIViewController {

    private(set) lazy var buttons: [UIButton] = createBoard()

    var buttonTapped: ((Int)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func createBoard() -> [UIButton] {
        (1...9).map { index in
            let boardItem = UIButton()

            let tapAction = UIAction(title: "Tap") { (action) in
                self.buttonTapped?(index)
            }
            boardItem.tag = index
            boardItem.addAction(tapAction, for: .touchUpInside)
            return boardItem
        }
    }


}

