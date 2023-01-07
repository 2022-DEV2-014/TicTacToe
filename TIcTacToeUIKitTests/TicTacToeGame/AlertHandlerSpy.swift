// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
@testable import TIcTacToeUIKit

class GameDisplaySpy: GameDisplay {

    var invokedShowError = false
    var invokedShowErrorCount = 0
    var showErrorParameters: String?
    var showErrorParametersList = [String]()

    func showError(message: String) {
        invokedShowError = true
        invokedShowErrorCount += 1
        showErrorParameters = message
        showErrorParametersList.append(message)
    }

    var invokedUpdateBoard = false
    var invokedUpdateBoardCount = 0
    var updateBoardParameters: [String]?
    var updateBoardParametersList = [[String]]()
    func updateBoard(tokens: [String]) {
        invokedUpdateBoard = true
        invokedUpdateBoardCount += 1
        updateBoardParameters = tokens
        updateBoardParametersList.append(tokens)
    }

}
