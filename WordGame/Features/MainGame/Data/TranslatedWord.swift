//
//  TranslatedWord.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/19/22.
//

import Foundation

struct TranslatedWord: Decodable {
    let eng: String
    let spa: String

    // MARK: Decodable
    private enum CodingKeys: String, CodingKey {
        case eng = "text_eng"
        case spa = "text_spa"
    }
}

