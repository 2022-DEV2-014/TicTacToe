// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import XCTest
@testable import TIcTacToeUIKit

class TicTacToePresenter {
    private let game: TicTacToe & Resetable

    init(game: TicTacToe & Resetable) {
        self.game = game
    }

    func userPlayedAt(position: Int) {
        do {
            try game.play(at: position)
        } catch {

        }
    }

    func userRequestedReset() {
        game.reset()
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

    func test_gameReset_isPassedAlongToTheGameEngine() {
        let game = GameSpy()
        let sut = TicTacToePresenter(game: game)

        sut.userRequestedReset()

        XCTAssertEqual(game.invokedResetCount, 1)
    }
}
