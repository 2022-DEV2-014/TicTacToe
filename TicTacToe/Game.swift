// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation

class Game {
    enum State {
        case ready
        case onGoing
    }

    let board = GameBoard()

    var currentPlayer: Player = .x
    var currentState: State = .ready

    func play(at position: CGPoint) {
        currentState = .onGoing
        currentPlayer = currentPlayer == .x ? .o : .x
    }
}
