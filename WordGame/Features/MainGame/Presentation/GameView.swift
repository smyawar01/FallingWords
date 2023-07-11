//
//  ContentView.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import SwiftUI

struct GameView<ViewModel: GameViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var animationDuration: Double = Constants.Animation.duration
    @State private var answeredAlready: Bool = false
    @State private var offSetChange: Double = Constants.Animation.offsetChange
    
    var body: some View {
        VStack(spacing: CGFloat(Theme.Spacing.standard)) {
            
            HStack {
                Spacer()
                CounterView(attempCount: viewModel.score)
            }
            Text(viewModel.currentWord.questionWord)
//            viewModel.onEvent = { offsetY in
//
//                FallingWordView(answerWord: viewModel.currentWord.answerWord,
//                                viewOffset: offsetY)
//            }
//                .onReceive(timer) { _ in
//
//                    animationDuration -= Constants.Animation.changeDuration
//                    if animationDuration <= 0 {
//
//                        self.stopTimer()
//                        self.resetToDefault()
//                        viewModel.currentWord.correctTranslation ?
//                        viewModel.onWrong() :
//                        viewModel.onCorrect()
//                        self.startTimerIfRequired()
//
//                    }
//                }
            Spacer()
                FooterView { actionType in }
        }
        .padding(CGFloat(Theme.Spacing.expanded))
        .onAppear {
            viewModel.startGame()
        }
        .alert(isPresented: $viewModel.gameEnded) {
            
            Alert(title: Text("End Game"),
                  message: Text("Your final score is \(viewModel.score.correct)"),
                  primaryButton: .default(Text("Restart"), action: { viewModel.startGame() }),
                  secondaryButton: .cancel(Text("Quit"), action: { viewModel.quit() })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MainGameFactory().makeViewModel()
        GameView(viewModel: vm)
    }
}
