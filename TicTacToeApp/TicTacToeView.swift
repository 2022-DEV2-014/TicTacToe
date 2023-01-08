// Created for TicTacToe in 2022
// Using Swift 5.0

import SwiftUI

// Created in pair with chat.openai.com
struct TicTacToeView: View {
    @ObservedObject var game = ObservableGame()
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

            Label(game.status, systemImage: "gamecontroller")
                .font(.title)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding()

            Button("Reset", role: .destructive, action: {
                self.game.reset()
            }).opacity(game.started ? 1 : 0)
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Move not allowed"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

extension TicTacToeView {
    func squareColor(at position: (row: Int, col: Int)) -> Color {
        self.game.token(at: position).squareColor
    }

    func playerToken(at position: (row: Int, col: Int)) -> String {
        self.game.token(at: position).rawValue
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
