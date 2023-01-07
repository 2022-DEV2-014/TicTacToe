// Created for TicTacToe in 2022
// Using Swift 5.0

import UIKit

class TicTacToeViewController: UIViewController {

    private(set) lazy var buttons: [UIButton] = createBoard()
    private(set) lazy var resetButton: UIButton = createReset()
    private var presenter: TicTacToePresenter

    init(presenter: TicTacToePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        presenter.displayIsReady()
    }

    func place(title: String, at boardCellIndex: Int) {
        buttons[boardCellIndex].setTitle(title, for: .normal)
    }

    func reset() {
        presenter.userRequestedReset()
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

        view.addSubview(resetButton)

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.topAnchor.constraint(equalTo: gridStackView.bottomAnchor, constant: 20).isActive = true
    }

    private func createBoard() -> [UIButton] {
        (1...9).map { index in
            let boardItem = UIButton()

            let tapAction = UIAction(title: "Tap") { (action) in
                self.presenter.userPlayedAt(position: index - 1)
            }
            boardItem.addAction(tapAction, for: .touchUpInside)
            boardItem.backgroundColor = .gray

            return boardItem
        }
    }

    private func createReset() -> UIButton {
        let action = UIAction { [weak self] _ in
            self?.reset()
        }
        let button = UIButton(type: .roundedRect, primaryAction: action)

        button.setTitle("Reset", for: .normal)
        return button
    }


}

