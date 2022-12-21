// Created for TicTacToe in 2022
// Using Swift 5.0

import SwiftUI

// Created in pair with chat.openai.com
struct TicTacToeView: View {
    @ObservedObject var game = ObservableGame()
    @State var refreshTrigger = false
    @State var buttonStates: [Bool] = Array(repeating: false, count: 9)
    @State var showingError = false
    @State var errorMessage = ""

    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { col in
                        ZStack {
                            Circle()
                                .fill(self.squareColor(at: (row, col)))
                                .scaleEffect(buttonStates[row * 3 + col] ? 1.1 : 1)
                                .onTapGesture {
                                    self.onButtonPressed(at: (row, col))
                                }

                            Text(playerToken(at: (row, col)))
                                .font(.system(size: 60))
                                .foregroundColor(.white)

                        }.frame(width: 100, height: 100)
                    }
                }
            }

            Text(game.game.currentState.description)
        }
        .id(refreshTrigger)
        .alert(isPresented: $showingError) {
            Alert(title: Text("Move not allowed"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}



extension TicTacToeView {
    func squareColor(at position: (row: Int, col: Int)) -> Color {
        self.game.game.board.player(at: position)?
            .squareColor ?? .blue
    }

    func playerToken(at position: (row: Int, col: Int)) -> String {
        self.game.game.board.player(at: position)?
            .token ?? ""
    }

    func onButtonPressed(at position: (row: Int, col: Int)) {
        do {
            try self.game.play(at: (position.row, position.col))
            withAnimation(
                Animation
                    .easeInOut(duration: 0.2)
                    .repeatCount(1, autoreverses: true)
            ) {
                self.buttonStates[position.row * 3 + position.col] = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(
                    Animation
                        .easeInOut(duration: 0.2)
                        .repeatCount(1, autoreverses: true)
                ) {
                    self.buttonStates[position.row * 3 + position.col] = false
                }
            }

        } catch {
            self.errorMessage = game.translateToHumanReadable(error: error)
            self.showingError = true
        }
    }
}
