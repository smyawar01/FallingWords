//
//  GameEngine.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/20/22.
//

import Foundation

protocol GameEngine {
    
    func scoreCalculation(current: ScoreConfig) -> Score
    func endGame(currentIndex: Int, incorrectCount: Int) -> Bool
    func makeRandomized(translatedWords: [TranslatedWord]) -> [RoundWord]
}

struct GameEngineImpl: GameEngine {
    
    let totalWordCountInRound: Int
    
    func scoreCalculation(current: ScoreConfig) -> Score {
        
        var correctCount = current.score.correct
        var wrongCount = current.score.wrong
        
        if current.correctTranslation && current.selectionAction ||
            !current.correctTranslation && !current.selectionAction {
            
            correctCount = correctCount + 1
        } else {
            wrongCount = wrongCount + 1
        }
        return .init(correct: correctCount,
                     wrong: wrongCount)
    }
    
    func endGame(currentIndex: Int, incorrectCount: Int) -> Bool {
        
        return currentIndex >= totalWordCountInRound || incorrectCount >= 3
    }
    func makeRandomized(translatedWords: [TranslatedWord]) -> [RoundWord] {
        
        let shuffledWords = translatedWords.shuffled().prefix(totalWordCountInRound)
        let oneFourth = totalWordCountInRound/4
        let correct: [RoundWord] = shuffledWords.prefix(oneFourth).map { word in
            
            return RoundWord(questionWord: word.eng,
                             answerWord: word.spa,
                             correctTranslation: true)
        }
        let correctOrWrong: [RoundWord] = shuffledWords.suffix(totalWordCountInRound-oneFourth).map {
            
            let allPossibleTranslations = Set(translatedWords.map { $0.spa })
            let answerWord = allPossibleTranslations.randomElement() ?? $0.spa
            return RoundWord(questionWord: $0.eng,
                             answerWord: answerWord,
                             correctTranslation: answerWord == $0.spa)
        }
        return (correct + correctOrWrong).shuffled()
    }
}
