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
    @State private var offsetY: Double = 0.0
    @State private var answeredAlready: Bool = false
    
    @State private var timer = Timer.publish(every: Constants.Animation.changeDuration,
                              on: .main,
                              in: .common).autoconnect()
    @State private var offSetChange: Double = Constants.Animation.offsetChange
    
    var body: some View {
        VStack(spacing: CGFloat(Theme.Spacing.standard)) {
            
            HStack {
                Spacer()
                CounterView(attempCount: viewModel.score)
            }
            Text(viewModel.currentWord.questionWord)
            Text(viewModel.currentWord.answerWord)
                .offset(y: offsetY)
                .onReceive(timer) { _ in
                    
                    animationDuration -= Constants.Animation.changeDuration
                    if animationDuration <= 0 {
                        
                        self.stopTimer()
                        self.resetToDefault()
                        viewModel.currentWord.correctTranslation ?
                        viewModel.onWrong() :
                        viewModel.onCorrect()
                        self.startTimerIfRequired()
                        
                    } else {
                        
                        withAnimation {
                            
                            offsetY += offSetChange
                        }
                    }
                }
            Spacer()
                FooterView { actionType in
                    
                    answeredAlready = true
                    self.stopTimer()
                    self.resetToDefault()
                    actionType ? viewModel.onCorrect(): viewModel.onWrong()
                    self.startTimerIfRequired()
                }
        }
        .padding(CGFloat(Theme.Spacing.expanded))
        .onAppear {
            viewModel.startGame()
        }
        .alert("Game End",
               isPresented: $viewModel.gameEnded,
               actions: {
                    Button {
                        viewModel.startGame()
                        self.startTimer()
                    } label: {
                        Text("Restart")
                    }
                    Button {
                        viewModel.startGame()
                        self.startTimer()
                    } label: {
                        Text("Quit")
                    }
            },
               message: {
            Text("Your final score is \(viewModel.score.correct)")
        })
    }
}
private extension GameView {
    
    private func startTimer() {
        
        self.timer = Timer.publish(every: Constants.Animation.changeDuration,
                                   on: .main,
                                   in: .common).autoconnect()
    }
    private func stopTimer() {
        
        self.timer.upstream.connect().cancel()
    }
    private func resetToDefault() {
        
        answeredAlready = false
        offsetY = 0.0
        animationDuration = Constants.Animation.duration
    }
    private func startTimerIfRequired() {
        
        if viewModel.gameEnded == false {
            self.startTimer()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MainGameFactory().makeViewModel()
        GameView(viewModel: vm)
    }
}
