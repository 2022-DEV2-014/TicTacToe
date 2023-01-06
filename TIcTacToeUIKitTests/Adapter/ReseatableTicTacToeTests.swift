// Created for TicTacToe in 2023
// Using Swift 5.0

import XCTest
import Foundation
@testable import TIcTacToeUIKit

class ReseatableTicTacToeTests: XCTestCase {
    func test_game_isResetted() throws {
        let sut = ReseatableTicTacToe()

        XCTAssertFalse(sut.started)

        try sut.play(at: 1)

        XCTAssertTrue(sut.started)

        sut.reset()

        XCTAssertFalse(sut.started)
    }

    func test_playInInvalidPosition_throwsAnError() throws {
        let sut = ReseatableTicTacToe()

        XCTAssertThrowsError(try sut.play(at: 9))
        XCTAssertThrowsError(try sut.play(at: -1))
    }
}
