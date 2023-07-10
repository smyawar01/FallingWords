//
//  WordSelectionCriteriaUseCase.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/19/22.
//

import Foundation

protocol WordSelectionUseCase {
    
    typealias WordResponse = (Result<[RoundWord], Error>) -> Void
    func execute(response: @escaping WordResponse)
}

struct WordSelectionUseCaseImpl: WordSelectionUseCase {
    
    let wordCount: Int
    let correctProbability: Float
    
    func execute(response: @escaping WordResponse) {
        
        
    }
}
