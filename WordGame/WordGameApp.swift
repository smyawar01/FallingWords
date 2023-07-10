//
//  WordGameApp.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import SwiftUI

@main
struct WordGameApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = MainGameFactory().makeViewModel()
            GameView(viewModel: vm)
        }
    }
}
