// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import XCTest
@testable import TIcTacToeUIKit

protocol AlertDisplayer: AnyObject {
    func displayError(message: String)
}

class TicTacToePresenter {
    private let game: TicTacToe & Resetable & TicTacToeErrorTranslator
    weak var alertDisplayer: AlertDisplayer?

    init(game: TicTacToe & Resetable & TicTacToeErrorTranslator) {
        self.game = game
    }

    func userPlayedAt(position: Int) {
        do {
            try game.play(at: position)
        } catch {
            let description = game.humanReadable(error: error)
            alertDisplayer?.displayError(message: description)
        }
    }

    func userRequestedReset() {
        game.reset()
    }

}

class AlertHandlerSpy: AlertDisplayer {

    var invokedDisplayError = false
    var invokedDisplayErrorCount = 0
    var displayErrorParameters: String?
    var displayErrorParametersList = [String]()

    func displayError(message: String) {
        invokedDisplayError = true
        invokedDisplayErrorCount += 1
        displayErrorParameters = message
        displayErrorParametersList.append(message)
    }

}


final class TicTacToePresenterTests: XCTestCase {

    func test_gameMoves_arePassedAlongToTheGameEngine() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)

        sut.userPlayedAt(position: 8)
        sut.userPlayedAt(position: 3)
        sut.userPlayedAt(position: 5)

        XCTAssertEqual(game.invokedPlayParametersList, [8, 3, 5])
        XCTAssertEqual(game.invokedPlayCount, 3)
    }

    func test_gameMoves_displayAMessageWhenAnErrorIsDetected() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)
        let alertHandler = AlertHandlerSpy()
        sut.alertDisplayer = alertHandler

        game.stubbedPlayError = NSError(domain: "anyError", code: -1)
        sut.userPlayedAt(position: 8)

        XCTAssertEqual(alertHandler.invokedDisplayErrorCount, 1)
        XCTAssertEqual(game.invokedHumanReadableCount, 1)
        XCTAssertEqual(game.invokedPlayCount, 1)
    }

    func test_gameReset_isPassedAlongToTheGameEngine() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)

        sut.userRequestedReset()

        XCTAssertEqual(game.invokedResetCount, 1)
    }
}
