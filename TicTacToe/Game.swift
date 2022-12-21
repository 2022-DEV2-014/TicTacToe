// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation

class Game {
    enum State {
        case ready
        case onGoing
    }

    private let board: GameBoard
    private(set) var currentPlayer: Player = .x
    private(set) var currentState: State = .ready


    init(board: GameBoard = .init()) {
        self.board = board
    }

    func play(at position: CGPoint) {
        currentState = .onGoing
        currentPlayer = currentPlayer == .x ? .o : .x
    }
}
