//
//  ContentView.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import SwiftUI

struct GameView<ViewModel: GameViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var showAlert: Bool
    @State var offsetY = 0.0
    
    var body: some View {
        VStack(spacing: CGFloat(Theme.Spacing.standard)) {
            
            HStack {
                Spacer()
                CounterView(attempCount: viewModel.score)
            }
            Text(viewModel.currentWord.questionWord)
            FallingWordView(answerWord: viewModel.currentWord.answerWord,
                            viewOffset: offsetY )
            Spacer()
            FooterView { viewModel.onAttemptAnswer(action: $0) }
        }
        .padding(CGFloat(Theme.Spacing.expanded))
        .onAppear { viewModel.startGame() }
        .alert(isPresented: $showAlert) {
            
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
