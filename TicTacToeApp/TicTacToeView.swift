// Created for TicTacToe in 2022
// Using Swift 5.0

import SwiftUI

// Created in pair with chat.openai.com
struct TicTacToeView: View {
    @ObservedObject var game = ObservableGame()
    @State var refreshTrigger = false
    @State var buttonStates: [Bool] = Array(repeating: false, count: 9)

    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { col in
                        ZStack {
                            Circle()
                                .fill(self.game.game.board.player(at: (row, col)) == "x" ? Color.red : self.game.game.board.player(at: (row, col)) == "o" ? Color.green : Color.blue)
                                .frame(width: 100, height: 100)
                                .scaleEffect(buttonStates[row * 3 + col] ? 1.1 : 1)
                                .onTapGesture {
                                    do {
                                        try self.game.play(at: (row, col))
                                        withAnimation(
                                            Animation
                                                .easeInOut(duration: 0.2)
                                                .repeatCount(1, autoreverses: true)
                                        ) {
                                            self.buttonStates[row * 3 + col] = true
                                        }

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            withAnimation(
                                                Animation
                                                    .easeInOut(duration: 0.2)
                                                    .repeatCount(1, autoreverses: true)
                                            ) {
                                                self.buttonStates[row * 3 + col] = false
                                            }
                                        }

                                    } catch {
                                        print(error)
                                    }
                                }

                            Text(self.game.game.board.player(at: (row, col)) == "x" ? "X" : self.game.game.board.player(at: (row, col)) == "o" ? "O" : "" )
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }

            Text(game.game.currentState.description)
        }.id(refreshTrigger)
    }
}
