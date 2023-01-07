// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation

protocol TicTacToe {
    var status: String { get }
    var started: Bool { get }
    var boardRepresentation: [String] { get }

    func play(at position: Int) throws
}

protocol Resetable {
    func reset()
}

protocol TicTacToeErrorTranslator {
    func humanReadable(error: Error) -> String
}
