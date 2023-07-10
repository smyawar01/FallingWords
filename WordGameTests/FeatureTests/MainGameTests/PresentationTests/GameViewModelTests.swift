//
//  GameViewModelTests.swift
//  WordGameTests
//
//  Created by muhammad Yawar on 11/20/22.
//

import XCTest
@testable import WordGame

class GameViewModelTests: XCTestCase {
    
    func test_initialize_viewModelWithDefaultState() throws {
        
        let (sut, _, _) = makeSUT()
        XCTAssertEqual(sut.score, Score(correct: 0, wrong: 0), "Score is 0 on game initialization.")
        XCTAssertEqual(sut.currentWord, RoundWord(questionWord: "",
                                                  answerWord: "",
                                                  correctTranslation: false), "Default round word on game initialization.")
        XCTAssertEqual(sut.gameEnded, false, "End game state is false on initialization.")
        
    }
    func test_startGame_viewModelLoadedWithData() throws {
        
        //Given
        let (sut, gameEngine, wordRepo) = makeSUT()
        wordRepo.result = .success(TranslatedWordFixture.loadWord())
        //When
        sut.startGame()
        //Than
        XCTAssertEqual(sut.score, Score(correct: 0, wrong: 0), "Score is 0 on game start.")
        XCTAssertTrue(wordRepo.wasLoadCalled, "Round Data was loaded from repository on game start.")
        XCTAssertTrue(gameEngine.wasMakeRandomizedCalled, "Randomized data on load.")
        XCTAssertEqual(sut.currentWord, gameEngine.firstWord, "First word is selected as currently showing word on game start.")
        XCTAssertEqual(sut.gameEnded, false, "End game state is false on initialization.")
        
    }
    private func makeSUT() -> (some GameViewModel, GameEngineMock, WordRepositoryMock) {
        
        let gameEngineMock = GameEngineMock()
        let wordRepoMock = WordRepositoryMock()
        let vm = GameViewModelImpl(wordRepo: wordRepoMock,
                                 gameEngine: gameEngineMock)
        return (vm, gameEngineMock, wordRepoMock)
    }
}

class GameEngineMock: GameEngine {
    
    var wasMakeRandomizedCalled = false
    var firstWord: RoundWord?
    func scoreCalculation(current: ScoreConfig) -> Score { Score(correct: 0, wrong: 0) }
    
    func endGame(currentIndex: Int, incorrectCount: Int) -> Bool { false }
    
    func makeRandomized(translatedWords: [TranslatedWord]) -> [RoundWord] {
        
        wasMakeRandomizedCalled = true
        let roundWords = translatedWords.map { RoundWord(questionWord: $0.eng,
                                                         answerWord: $0.spa,
                                                         correctTranslation: true)  }
        firstWord = roundWords[0]
        return roundWords
    }
}
class WordRepositoryMock: WordRepository {
    
    var wasLoadCalled = false
    var result: Result<[TranslatedWord], FileError>?
    func load() -> Result<[TranslatedWord], FileError> {
        
        wasLoadCalled = true
        return result ?? .failure(.invalidData("File Error"))
    }
}
