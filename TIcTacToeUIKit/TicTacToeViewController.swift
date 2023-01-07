// Created for TicTacToe in 2022
// Using Swift 5.0

import UIKit

class TicTacToeViewController: UIViewController {

    private(set) lazy var buttons: [UIButton] = createBoard()

    var buttonTapped: ((Int)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    func place(title: String, at boardCellIndex: Int) {
        buttons[boardCellIndex].setTitle(title, for: .normal)
    }

    func reset() {
        buttons.forEach { button in
            button.setTitle("", for: .normal)
        }
    }

    private func setupInterface() {

        let rowOneButtons = Array(buttons.prefix(3))
        let rowTwoButtons = Array(buttons.prefix(6).suffix(3))
        let rowThreeButtons = Array(buttons.suffix(3))

        let row1StackView = UIStackView(arrangedSubviews: rowOneButtons)
        let row2StackView = UIStackView(arrangedSubviews: rowTwoButtons)
        let row3StackView = UIStackView(arrangedSubviews: rowThreeButtons)

        [
            row1StackView,
            row2StackView,
            row3StackView
        ].forEach { stack in
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 10
        }

        let gridStackView = UIStackView(arrangedSubviews: [row1StackView, row2StackView, row3StackView])
        gridStackView.axis = .vertical
        gridStackView.distribution = .fillEqually
        gridStackView.spacing = 10

        view.addSubview(gridStackView)

        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        gridStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gridStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func createBoard() -> [UIButton] {
        (1...9).map { index in
            let boardItem = UIButton()

            let tapAction = UIAction(title: "Tap") { (action) in
                self.buttonTapped?(index)
            }
            boardItem.addAction(tapAction, for: .touchUpInside)
            boardItem.backgroundColor = .gray

            return boardItem
        }
    }


}

