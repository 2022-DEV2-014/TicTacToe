// Created for TicTacToe in 2022
// Using Swift 5.0

import Foundation
@testable import TicTacToe

extension GameBoard {
    convenience init(boardRepresentation: String) {
        self.init()

        let positions: [Player?] = boardRepresentation
            .lowercased()
            .filter { $0 == "x" || $0 == "o" || $0 == "_" }
            .map {
                if $0 == "x" {
                    return .x
                }
                if $0 == "o" {
                    return .o
                }
                return nil
            }


        positions
            .enumerated()
            .forEach { (index, item) in
                guard let player = item else {
                    return
                }
                forceInsert(player: player, at: index)
            }
    }
}
