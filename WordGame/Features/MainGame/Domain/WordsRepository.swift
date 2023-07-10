//
//  WordsRepository.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/19/22.
//

import Foundation

enum FileError: Error {
    
    case invalidUrl(String)
    case invalidData(String)
    case decodingError(String)
}

protocol WordRepository {
    func load() -> Result<[TranslatedWord], FileError>
}

struct WordRepositoryLocal: WordRepository {
    
    let fileName: String
    let decoder: JSONDecoder
    func load() -> Result<[TranslatedWord], FileError>  {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            
            return .failure(.invalidUrl("Invalid Url. Please check the file name."))
        }
        guard let data = try? Data(contentsOf: url) else {
            
            return .failure(.invalidData("Invalid Data."))
        }
        guard let translatedWords = try? decoder.decode([TranslatedWord].self, from: data) else {
            
            return .failure(.decodingError("Decoding Error."))
        }
        return .success(translatedWords)
    }
}
