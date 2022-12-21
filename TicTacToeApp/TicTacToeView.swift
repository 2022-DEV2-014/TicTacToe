// Created for TicTacToe in 2022
// Using Swift 5.0

import SwiftUI

// Created in pair with chat.openai.com
struct TicTacToeView: View {
    @ObservedObject var game = ObservableGame()
    @State var refreshTrigger = false

    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { col in
                        Button(action: {
                            do {
                                try self.game.play(at: (row, col))
                                refreshTrigger.toggle()
                            } catch {
                                print(error)
                            }
                        }) {
                            Text(self.game.game.board.player(at: (row, col)))
                        }
                    }
                }
            }

            Text(game.game.currentState.description)
        }.id(refreshTrigger)
    }
}
