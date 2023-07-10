//
//  FooterView.swift
//  WordGame
//
//  Created by muhammad Yawar on 11/17/22.
//

import SwiftUI

struct FooterView: View {
    
    let onPress: ((Bool) -> ())
    var body: some View {
        HStack(spacing: 100) {
            
            Button("Correct") {
                onPress(true)
            }
            Button("Wrong") {
                onPress(false)
            }
        }
    }
}
//MARK: Test Helper View
struct ButtonClickView: View {
    
    @State var str = ""
    
    var body: some View {
        
        VStack {
            
            FooterView { actionType in
                
                str = actionType == true ? "Correct": "Wrong"
            }
            Text(str)
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        
        ButtonClickView()
    }
}
