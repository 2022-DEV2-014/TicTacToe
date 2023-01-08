// Created for TicTacToe in 2023
// Using Swift 5.0

import XCTest
import Foundation
@testable import TIcTacToeUIKit

class ReseatableTicTacToeTests: XCTestCase {
    func test_game_isResetted() throws {
        let sut = makeSut()

        XCTAssertFalse(sut.started)

        try sut.play(at: 1)

        XCTAssertTrue(sut.started)

        sut.reset()

        XCTAssertFalse(sut.started)
    }

    func test_playInInvalidPosition_throwsAnError() throws {
        let sut = makeSut()

        XCTAssertThrowsError(try sut.play(at: 9))
        XCTAssertThrowsError(try sut.play(at: -1))
    }

    func test_playInDuplicatedPosition_throwsAnErrorThatIsHumanlyReadable() throws {
        let sut = makeSut()

        do {
            try sut.play(at: 8)
            try sut.play(at: 8)
            XCTFail("Expected to catch an error")
        } catch {
            let message = sut.humanReadable(error: error)
            XCTAssertEqual(message, "There's already a piece in this position")
        }
    }

    func test_playInInvalidPosition_throwsAnErrorThatIsHumanlyReadable() throws {
        let sut = makeSut()

        do {
            try sut.play(at: 9)
            XCTFail("Expected to catch an error")
        } catch {
            let message = sut.humanReadable(error: error)
            XCTAssertEqual(message, "Movement is not valid")
        }
    }

    func test_playAfterEndOfGame_throwsAnErrorThatIsHumanlyReadable() throws {
        let sut = makeSut()

        try sut.play(at: 0)
        try sut.play(at: 3)
        try sut.play(at: 1)
        try sut.play(at: 6)
        try sut.play(at: 2)

        do {
            try sut.play(at: 7)
            XCTFail("Expected to catch an error")
        } catch {
            let message = sut.humanReadable(error: error)
            XCTAssertEqual(message, "The game has ended, no new moves are allowed")
        }
    }

    //MARK - Helpers

    private func makeSut() -> ReseatableTicTacToe {
        let sut = ReseatableTicTacToe()

        trackForMemoryLeaks(sut)

        return sut
    }
}
