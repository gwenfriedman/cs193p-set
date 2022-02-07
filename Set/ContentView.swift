//
//  ContentView.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            Text("Set")
//            AspectVGrid(items: self.game.cards, aspectRatio: <#T##CGFloat#>, content: <#T##(_) -> _#>)
            
            Button {
                game.newGame()
            } label: {
                Text("New Game")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
