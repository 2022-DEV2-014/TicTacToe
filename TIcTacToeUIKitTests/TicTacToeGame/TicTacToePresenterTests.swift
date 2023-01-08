// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import XCTest
@testable import TIcTacToeUIKit

final class TicTacToePresenterTests: XCTestCase {

    func test_gameMoves_arePassedAlongToTheGameEngine() {
        let (sut, game, _) = makeSUT()

        sut.userPlayedAt(position: 8)
        sut.userPlayedAt(position: 3)
        sut.userPlayedAt(position: 5)

        XCTAssertEqual(game.invokedPlayParametersList, [8, 3, 5])
        XCTAssertEqual(game.invokedPlayCount, 3)
    }

    func test_afterAMove_anUpdatedBoardIsPassedToTheDisplay() {
        let (sut, game, display) = makeSUT()
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
        let (sut, game, display) = makeSUT()
        game.stubbedPlayError = NSError(domain: "anyError", code: -1)

        sut.userPlayedAt(position: 8)

        XCTAssertEqual(display.invokedShowErrorCount, 1)
        XCTAssertEqual(game.invokedHumanReadableCount, 1)
        XCTAssertEqual(game.invokedPlayCount, 1)
    }

    func test_gameReset_isPassedAlongToTheGameEngine() {
        let (sut, game, display) = makeSUT()

        sut.userRequestedReset()

        XCTAssertEqual(game.invokedResetCount, 1)
        XCTAssertTrue(display.invokedUpdateBoard)
    }

    func test_afterAGameMove_stateOfTheGameIsRequestedAndUpdated() {
        let (sut, game, display) = makeSUT()

        game.stubbedStatus = "Random Status"
        sut.userPlayedAt(position: 8)
        game.stubbedStatus = "Another Random Status"
        sut.userPlayedAt(position: 3)

        XCTAssertEqual(game.invokedStatusGetterCount, 2)
        XCTAssertEqual(display.invokedDisplayStateCount, 2)
        XCTAssertEqual(display.displayStateParametersList, ["Random Status", "Another Random Status"])
    }

    //MARK - Helpers

    private func makeSUT() -> (TicTacToePresenter, GameSpy, GameDisplaySpy) {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)
        let display = GameDisplaySpy()
        sut.display = display

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(display)
        trackForMemoryLeaks(game)

        return (sut, game, display)
    }
}
