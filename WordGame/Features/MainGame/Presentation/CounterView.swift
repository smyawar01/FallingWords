//
//  CounterView.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/18/22.
//

import SwiftUI

struct CounterView: View {
    
    let attempCount: Score
    
    var body: some View {
        VStack {
        Text("Correct attempts: \(attempCount.correct)")
        Text("Wrong attempts: \(attempCount.wrong)")
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let score = Score(correct: 5, wrong: 3)
        CounterView(attempCount: score)
    }
}
