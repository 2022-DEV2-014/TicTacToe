// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TIcTacToeUIKit

final class TicTacToeViewControllerTests: XCTestCase {

    func test_controller_isInitialised() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.view.backgroundColor, .blue)
    }
}
