// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation

protocol TicTacToe {
    func play(at position: Int) throws

    var status: String { get }
    var started: Bool { get }
}

protocol Resetable {
    func reset()
}

protocol TicTacToeErrorTranslator {
    func humanReadable(error: Error) -> String
}
