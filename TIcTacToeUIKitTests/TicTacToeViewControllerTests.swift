// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TIcTacToeUIKit

final class TicTacToeViewControllerTests: XCTestCase {

    func test_board_has9Buttons() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.buttons.count, 9)
    }

    func test_board_has9IdentifiedButtonsFrom1to9() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        let buttonsId = sut.buttons.map(\.tag)
        XCTAssertEqual(buttonsId, Array(1...9))
    }
}
