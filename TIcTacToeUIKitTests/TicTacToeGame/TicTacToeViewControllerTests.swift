// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TIcTacToeUIKit

final class TicTacToeViewControllerTests: XCTestCase {

    func test_board_has9Buttons() {
        let (sut, _) = makeSut(attachPresenter: false)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.buttons.count, 9)
    }

    func test_board_buttonsAreArranged() {
        let (sut, _) = makeSut(attachPresenter: false)
        makeVisible(sut)

        let zeroFrames = sut.buttons
            .map(\.frame)
            .filter { $0 == .zero }

        XCTAssertTrue(zeroFrames.isEmpty)
    }

    func test_placingAnItemInBoard_happensAtIntendedLocation() {
        let (sut, _) = makeSut(attachPresenter: false)

        sut.loadViewIfNeeded()

        sut.place(title: "X", at: 4)

        XCTAssertEqual(sut.buttons[4].currentTitle, "X")
    }

    func test_boardIntegration_buttonsAreTappableAndThoseTapsReachTheGameEngine() {
        let (sut, gameSpy) = makeSut(attachPresenter: false)

        sut.loadViewIfNeeded()

        sut.buttons.forEach { button in
            button.simulateTap()
        }

        XCTAssertEqual(gameSpy.invokedPlayParametersList, Array(0..<9))
    }

    func test_boardIntegration_whenViewIsReadyTheBoardUpdateIsTriggered() {
        let (sut, gameSpy) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertEqual(gameSpy.invokedBoardRepresentationGetterCount, 1)
    }

    func test_boardIntegration_boardIsUpdatedAfterEachTap() {
        let (sut, gameSpy) = makeSut()

        sut.loadViewIfNeeded()

        sut.buttons.forEach { button in
            button.simulateTap()
        }

        XCTAssertEqual(gameSpy.invokedBoardRepresentationGetterCount, 10)
    }

    func test_aReset_clearsAllTitles() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()
        sut.place(title: "X", at: 4)

        sut.reset()

        let titles = sut.buttons
            .compactMap(\.currentTitle)
        let emptyTitles = titles.filter(\.isEmpty)

        XCTAssertEqual(emptyTitles.count, 9)
    }

    func test_showError_displaysAnAlert() {
        let (sut, _) = makeSut(attachPresenter: false)
        makeVisible(sut)

        sut.showError(message: "Error Random")

        guard let alert = sut.presentedViewController as? UIAlertController else {
            XCTFail("When an error occurs, an alert is expected to be shown")
            return
        }
        XCTAssertEqual(alert.message, "Error Random")
    }

    func test_boardIntegration_resetRequestIsSentAfterTapOnIt() {
        let (sut, gameSpy) = makeSut()

        sut.loadViewIfNeeded()

        sut.resetButton.simulateTap()

        XCTAssertEqual(gameSpy.invokedResetCount, 1)
    }

    func test_reset_isVisibleAndArranged() {
        let (sut, _) = makeSut(attachPresenter: false)
        makeVisible(sut)

        XCTAssertNotEqual(sut.resetButton.frame, .zero)
    }

    //MARK - Helpers

    func makeSut(attachPresenter: Bool = true) -> (TicTacToeViewController, GameSpy) {
        let gameSpy = GameSpy()
        let presenter = TicTacToePresenter(game: gameSpy)
        let sut = TicTacToeViewController(presenter: presenter)

        if attachPresenter {
            presenter.display = sut
        }

        return (sut, gameSpy)
    }

    func makeVisible(_ sut: TicTacToeViewController) {
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
    }

}
