//
//  GameViewModel.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import Foundation

enum GameViewState {
    
    case `default`
    case started(RoundWord, Score)
    case ended(score: Score)
    case falling(Double)
}
protocol GameViewModel: ObservableObject {
    
    var gameState: GameViewState { get set }
    var score: Score { get }
    var currentWord: RoundWord { get }
    func startGame()
    func onAttemptAnswer(action: Bool)
    func quit()
}

class GameViewModelImpl: GameViewModel {
    
    typealias WordResponse = (Result<[RoundWord], Error>) -> Void
    
    @Published private(set) var score: Score = .init(correct: 0, wrong: 0)
    @Published var currentWord: RoundWord = .init(questionWord: "",
                                                  answerWord: "", correctTranslation: false)
    @Published var gameState: GameViewState = .default
    
    private var roundWords: [RoundWord] = []
    private let wordRepository: WordRepository
    private let gameEngine: GameEngine
    
    //MARK: Init
    init(wordRepo: WordRepository , gameEngine: GameEngine) {
        
        self.wordRepository = wordRepo
        self.gameEngine = gameEngine
    }
    
    func startGame() {
        
        self.load { [weak self] result in
            
            guard let self = self else { return }
            switch result {

            case .success(let words):
                
                guard !words.isEmpty else { return }
                self.roundWords = words
                self.currentWord = self.roundWords.first!
                self.setGameState(state: .started(self.currentWord, .init(correct: 0, wrong: 0)))
                
            case .failure(let error):

                print("\(error)")
            }
        }
    }
    
    func onAttemptAnswer(action: Bool) {
        
        onAnswerSelection(with: action)
    }
    func quit() { }
}
//MARK: Game Flow Logic

private extension GameViewModelImpl {
    
    private func onAnswerSelection(with actionType: Bool) {
        
        let scoreConfig = ScoreConfig(correctTranslation: currentWord.correctTranslation,
                                      selectionAction: actionType,
                                      score: Score(correct: score.correct,
                                                   wrong: score.wrong))
        score = gameEngine.scoreCalculation(current: scoreConfig)
        proceedToNextOrEndGame(score: score)
    }
    private func proceedToNextOrEndGame(score: Score) {
        
        let currentIndex = currentIndex(score: score)
        if gameEngine.endGame(currentIndex: currentIndex,
                              incorrectCount: score.wrong) {
            setGameState(state: .ended(score: score))
        } else {
            
            currentWord = roundWords[currentIndex + 1]
        }
    }
}
//MARK: Helper Methods

extension GameViewModelImpl {
    
    private func setGameState(state: GameViewState) {
        
        gameState = state
    }
    private func currentIndex(score: Score) -> Int {
        
        return score.correct + score.wrong
    }
    private func defaultScore() -> Score {
        
        return .init(correct: 0, wrong: 0)
    }
    private func resetToDefault() {
        
        score = defaultScore()
    }
    private func load(response: @escaping WordResponse) {
        
        let wordLoadingResult = wordRepository.load()
        switch wordLoadingResult {
            
        case .success(let words):
            
            let roundWords = gameEngine.makeRandomized(translatedWords: words)
            return response(.success(roundWords))
            
        case .failure(let error):
            
            return response(.failure(error))
        }
    }
}
