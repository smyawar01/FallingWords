//
//  MainGameFactory.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/19/22.
//

import Foundation

struct MainGameFactory {
    
    func makeViewModel() -> some GameViewModel {
        
        let viewModel = GameViewModelImpl(wordRepo: makeWordRepository(),
                                          gameEngine: makeGameEngine())
        return viewModel
    }
}
private extension MainGameFactory {
    
    private func makeWordRepository() -> WordRepository {
        
        return WordRepositoryLocal(fileName: "words.json",
                                   decoder: JSONDecoder())
    }
    private func makeGameEngine() -> GameEngine {
        
        return GameEngineImpl(totalWordCountInRound: 15)
    }
}
