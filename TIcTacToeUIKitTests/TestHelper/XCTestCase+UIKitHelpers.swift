// Created for TicTacToe in 2023
// Using Swift 5.0

import XCTest

extension XCTestCase {
    func captureAndDismissAlert(presentedBy sut: UIViewController) -> UIAlertController? {
        guard let alert = sut.presentedViewController as? UIAlertController else {
            return nil
        }
        let wait = expectation(description: "Wait for dismissal")
        alert.dismiss(animated: false) {
            wait.fulfill()
        }
        waitForExpectations(timeout: 5)

        return alert
    }

    func makeVisible(_ sut: UIViewController) {

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

    func removeFromWindow(_ sut: UIViewController) {

        RunLoop.main.run(until: .now)

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .forEach { scene in
                scene.windows.forEach { window in
                    window.rootViewController = nil
                }
            }

        RunLoop.main.run(until: .now)
    }

    func whilePresentedInScreenAndVisible(_ sut: UIViewController, perform: ()->Void) {
        makeVisible(sut)

        perform()

        removeFromWindow(sut)
    }
}
