// Created for TicTacToe in 2022
// Using Swift 5.0

import XCTest
@testable import TIcTacToeUIKit

final class TicTacToeViewControllerTests: XCTestCase {

    func test_board_has9Buttons() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.buttons.count, 9)
    }

    func test_board_has9IdentifiedButtonsFrom1to9() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        let buttonsId = sut.buttons.map(\.currentTitle)
        XCTAssertEqual(buttonsId, Array(1...9).map(\.description))
    }

    func test_board_buttonsAreTappable() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)
        var tappedButtons = [Int]()
        let buttonTapped = { index in
            tappedButtons.append(index)
        }
        sut.buttonTapped = buttonTapped
        sut.loadViewIfNeeded()

        sut.buttons.forEach { button in
            button.simulateTap()
        }
        
        XCTAssertEqual(tappedButtons, Array(1...9))
    }

    func test_board_buttonsAreArranged() {
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

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
        let sut = TicTacToeViewController(nibName: nil, bundle: nil)

        sut.loadViewIfNeeded()

        sut.place(title: "X", at: 4)

        XCTAssertEqual(sut.buttons[4].currentTitle, "X")
    }
}
