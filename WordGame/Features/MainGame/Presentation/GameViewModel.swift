//
//  GameViewModel.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import Foundation

protocol GameViewModel: ObservableObject {
    
    var score: Score { get }
    var currentWord: RoundWord { get }
    var gameEnded: Bool { get set }
    func startGame()
    func onCorrect()
    func onWrong()
    func quit()
}

class GameViewModelImpl: GameViewModel {
    
    @Published var score: Score = .init(correct: 0, wrong: 0)
    @Published var currentWord: RoundWord = RoundWord(questionWord: "",
                                                      answerWord: "",
                                                      correctTranslation: false)
    @Published var gameEnded: Bool = false
    
    typealias WordResponse = (Result<[RoundWord], Error>) -> Void
    
    private var roundWords: [RoundWord] = []
    private let wordRepository: WordRepository
    private let gameEngine: GameEngine
    
    //MARK: Init
    init(wordRepo: WordRepository , gameEngine: GameEngine) {
        
        self.wordRepository = wordRepo
        self.gameEngine = gameEngine
    }
    
    func startGame() {
        
        resetToDefault()
        self.load { [weak self] result in
            
            guard let self = self else { return }
            switch result {

            case .success(let words):
                
                guard !words.isEmpty else { return }
                self.roundWords = words
                self.currentWord = self.roundWords[0]
                
            case .failure(let error):

                print("\(error)")
            }
        }
    }
    
    func onCorrect() {
        
        onAnswerSelection(with: true)
    }
    
    func onWrong() {
        
        onAnswerSelection(with: false)
    }
    func quit() {
    }
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
            gameEnded = true
        } else {
            
            currentWord = roundWords[currentIndex + 1]
        }
    }
}
//MARK: Helper Methods

extension GameViewModelImpl {
    
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
