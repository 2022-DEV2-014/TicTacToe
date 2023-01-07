// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation

protocol GameDisplay: AnyObject {
    func showError(message: String)
    func updateBoard(tokens: [String])
}
