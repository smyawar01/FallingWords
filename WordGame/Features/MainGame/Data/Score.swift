//
//  Score.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/20/22.
//

import Foundation

struct Score: Equatable {
    
    let correct: Int
    let wrong: Int
}

struct ScoreConfig {
    
    let correctTranslation: Bool
    let selectionAction: Bool
    let score: Score
}
