// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import XCTest
@testable import TIcTacToeUIKit

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

    func test_afterAMove_anUpdatedBoardIsPassedToTheDisplay() {
        let game = GameSpy()
        let display = GameDisplaySpy()
        let sut = TicTacToePresenter(game: game)
        sut.display = display
        game.stubbedBoardRepresentation = [
            "X","O","",
            "" ,"" ,"X",
            "O","X","",
        ]

        sut.userPlayedAt(position: 8)

        XCTAssertEqual(display.updateBoardParameters, [
            "X","O", "",
            "", "", "X",
            "O","X", "",
        ])
    }

    func test_gameMoves_displayAMessageWhenAnErrorIsDetected() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)
        let display = GameDisplaySpy()
        sut.display = display

        game.stubbedPlayError = NSError(domain: "anyError", code: -1)
        sut.userPlayedAt(position: 8)

        XCTAssertEqual(display.invokedShowErrorCount, 1)
        XCTAssertEqual(game.invokedHumanReadableCount, 1)
        XCTAssertEqual(game.invokedPlayCount, 1)
    }

    func test_gameReset_isPassedAlongToTheGameEngine() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)
        let display = GameDisplaySpy()
        sut.display = display

        sut.userRequestedReset()

        XCTAssertEqual(game.invokedResetCount, 1)
        XCTAssertTrue(display.invokedUpdateBoard)
    }

    
}
