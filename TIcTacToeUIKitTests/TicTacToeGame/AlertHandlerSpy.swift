// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
@testable import TIcTacToeUIKit

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
