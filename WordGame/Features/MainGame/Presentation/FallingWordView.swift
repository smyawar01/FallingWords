//
//  FallingWordView.swift
//  WordGame
//
//  Created by muhammad Yawar on 7/11/23.
//

import SwiftUI

struct FallingWordView: View {
    
    let answerWord: String
    let viewOffset: Double
    var body: some View {
        Text(answerWord)
            .offset(y: viewOffset)
    }
}

struct FallingWordView_Previews: PreviewProvider {
    static var previews: some View {
        FallingWordView(answerWord: "Answer of the question.",
                        viewOffset: 20);
    }
}
