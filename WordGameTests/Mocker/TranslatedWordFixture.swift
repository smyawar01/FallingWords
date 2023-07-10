//
//  TranslatedWordFixture.swift
//  WordGameTests
//
//  Created by muhammad Yawar on 11/20/22.
//

import Foundation
@testable import WordGame

struct TranslatedWordFixture {
    
    static func loadWord() -> [TranslatedWord] {
        
        return [
            TranslatedWord(eng: "primary school" , spa: "escuela primaria"),
            TranslatedWord(eng: "teacher" , spa: "profesor / profesora"),
            TranslatedWord(eng: "pupil" , spa: "alumno / alumna"),
            TranslatedWord(eng: "holidays" , spa: "vacaciones"),
            TranslatedWord(eng: "class" , spa: "curso"),
            TranslatedWord(eng: "bell" , spa: "timbre"),
            TranslatedWord(eng: "group" , spa: "grupo"),
            TranslatedWord(eng: "exercise book" , spa: "cuaderno"),
            TranslatedWord(eng: "quiet" , spa: "quieto"),
            TranslatedWord(eng: "(to) answer" , spa: "responder"),
            TranslatedWord(eng: "headteacher" , spa: "director del colegio / directora del colegio"),
            TranslatedWord(eng: "state school" , spa: "colegio público"),
            TranslatedWord(eng: "private school" , spa: "colegio privado"),
            TranslatedWord(eng: "school bus" , spa: "autobús escolar"),
            TranslatedWord(eng: "trick" , spa: "jugarreta"),
            TranslatedWord(eng: "pair" , spa: "pareja"),
            TranslatedWord(eng: "exercise" , spa: "ejercicio"),
            TranslatedWord(eng: "lunch box" , spa: "fiambrera"),
            TranslatedWord(eng: "neat" , spa: "ordenado"),
            TranslatedWord(eng: "motivated" , spa: "motivado"),
            ]
    }
}
