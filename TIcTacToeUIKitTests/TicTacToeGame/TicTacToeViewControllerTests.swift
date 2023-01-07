// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TIcTacToeUIKit

final class TicTacToeViewControllerTests: XCTestCase {

    func test_board_has9Buttons() {
        let sut = TicTacToeViewController(presenter: TicTacToePresenter(game: GameSpy()))

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.buttons.count, 9)
    }

    func test_board_buttonsAreArranged() {
        let sut = TicTacToeViewController(presenter: TicTacToePresenter(game: GameSpy()))
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = (scene as? UIWindowScene) else {
            XCTFail("Can't find a window scene")
            return
        }
        let mainWindow = windowScene.windows.first(where: { $0.isKeyWindow })
        mainWindow?.rootViewController = sut
        mainWindow?.makeKeyAndVisible()

        sut.loadViewIfNeeded()
        RunLoop.main.run(until: .now)

        let zeroFrames = sut.buttons.map(\.frame).filter { $0 == .zero }

        XCTAssertTrue(zeroFrames.isEmpty)
    }

    func test_placingAnItemInBoard_happensAtIntendedLocation() {
        let sut = TicTacToeViewController(presenter: TicTacToePresenter(game: GameSpy()))
        sut.loadViewIfNeeded()

        sut.place(title: "X", at: 4)

        XCTAssertEqual(sut.buttons[4].currentTitle, "X")
    }

    func test_boardIntegration_buttonsAreTappableAndThoseTapsReachTheGameEngine() {
        let gameSpy = GameSpy()
        let presenter = TicTacToePresenter(game: gameSpy)
        let sut = TicTacToeViewController(presenter: presenter)

        sut.loadViewIfNeeded()

        sut.buttons.forEach { button in
            button.simulateTap()
        }

        XCTAssertEqual(gameSpy.invokedPlayParametersList, Array(0..<9))
    }

    func test_boardIntegration_whenViewIsReadyTheBoardUpdateIsTriggered() {
        let gameSpy = GameSpy()
        let presenter = TicTacToePresenter(game: gameSpy)
        let sut = TicTacToeViewController(presenter: presenter)
        presenter.display = sut

        sut.loadViewIfNeeded()

        XCTAssertEqual(gameSpy.invokedBoardRepresentationGetterCount, 1)
    }

    func test_boardIntegration_boardIsUpdatedAfterEachTap() {
        let gameSpy = GameSpy()
        let presenter = TicTacToePresenter(game: gameSpy)
        let sut = TicTacToeViewController(presenter: presenter)
        presenter.display = sut

        sut.loadViewIfNeeded()

        sut.buttons.forEach { button in
            button.simulateTap()
        }

        XCTAssertEqual(gameSpy.invokedBoardRepresentationGetterCount, 10)
    }

    func test_aReset_clearsAllTitles() {
        let gameSpy = GameSpy()
        let presenter = TicTacToePresenter(game: gameSpy)
        let sut = TicTacToeViewController(presenter: presenter)
        presenter.display = sut
        sut.loadViewIfNeeded()
        sut.place(title: "X", at: 4)

        sut.reset()

        let titles = sut.buttons.compactMap(\.currentTitle)
        let emptyTitles = titles.filter(\.isEmpty)

        XCTAssertEqual(emptyTitles.count, 9)
    }
}
