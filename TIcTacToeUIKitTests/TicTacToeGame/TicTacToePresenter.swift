// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
import XCTest
@testable import TIcTacToeUIKit

class TicTacToePresenter {
    let game: TicTacToe & Resetable

    init(game: TicTacToe & Resetable) {
        self.game = game
    }

}

class GameDummy: Resetable & TicTacToe {
    var started: Bool = false
    var status: String = ""

    func play(at position: Int) throws {

    }

    func reset() {

    }
}

final class TicTacToePresenterTests: XCTestCase {

    func test_init() {
        let game = GameDummy()
        let sut = TicTacToePresenter(game: game)

        XCTAssertNotNil(sut)
    }
}
