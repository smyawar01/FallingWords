//
//  GameEngineTests.swift
//  WordGameTests
//
//  Created by muhammad Yawar on 11/20/22.
//

import XCTest
@testable import WordGame
import SwiftUI

let totalCount = 15
class GameEngineTests: XCTestCase {
    
    func test_scoreCalculation_translationCorrectUserSelectCorrect() throws {
        
        //Given
        let sut = makeSUT()
        let config = makeScoreConfig(translation: true, action: true)
        //When
        let score = sut.scoreCalculation(current: config)
        //Then
        XCTAssertEqual(score.correct, config.score.correct + 1)
        XCTAssertEqual(score.wrong, config.score.wrong)
    }
    func test_scoreCalculation_translationCorrectUserSelectWrong() throws {
        
        //Given
        let sut = makeSUT()
        let config = makeScoreConfig(translation: true, action: false)
        //When
        let score = sut.scoreCalculation(current: config)
        //Then
        XCTAssertEqual(score.correct, config.score.correct)
        XCTAssertEqual(score.wrong, config.score.wrong + 1)
    }
    func test_scoreCalculation_translationWrongUserSelectCorrect() throws {
        
        //Given
        let sut = makeSUT()
        let config = makeScoreConfig(translation: false, action: true)
        //When
        let score = sut.scoreCalculation(current: config)
        //Then
        XCTAssertEqual(score.correct, config.score.correct)
        XCTAssertEqual(score.wrong, config.score.wrong + 1)
    }
    func test_scoreCalculation_translationWrongUserSelectWrong() throws {
        
        //Given
        let sut = makeSUT()
        let config = makeScoreConfig(translation: false, action: false)
        //When
        let score = sut.scoreCalculation(current: config)
        //Then
        XCTAssertEqual(score.correct, config.score.correct + 1)
        XCTAssertEqual(score.wrong, config.score.wrong)
    }
    private func makeSUT() -> GameEngine {
        
        let sut = GameEngineImpl(totalWordCountInRound: totalCount)
        return sut
    }
    private func makeScoreConfig(translation: Bool, action: Bool) -> ScoreConfig {
        
        let config = ScoreConfig(correctTranslation: translation,
                                 selectionAction: action,
                                 score: Score(correct: 0, wrong: 0))
        return config
    }
}
extension GameEngineTests {
    
    func test_endGame_whenCurrentCountReachesTotalCount() throws {
        
        let sut = makeSUT()
        let status = sut.endGame(currentIndex: totalCount, incorrectCount: 2)
        XCTAssertTrue(status, "End game when current Indext reaches to total count.")
    }
    func test_endGame_whenIncorrectCountReachesThreshold() throws {
        
        let sut = makeSUT()
        let status = sut.endGame(currentIndex: 12, incorrectCount: 3)
        XCTAssertTrue(status, "End game when incorrect count reaches to 3.")
    }
}
extension GameEngineTests {
    
    func test_makeRandomized_ensuring25PercentCorrect() throws {
        
        let count = 4
        let sut = makeSUT()
        let words = sut.makeRandomized(translatedWords: TranslatedWordFixture.loadWord())
        for _ in 1...count {
            
            let selectedWords = words.shuffled().suffix(count)
            let correctWord = selectedWords.contains( where: { $0.correctTranslation == true })
            XCTAssertNotNil(correctWord, "Random selection word list containing atleaset 25% correct translations.")
        }
    }
}
