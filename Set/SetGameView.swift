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
            
            
            //TODO: set minimum size
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        //Intent to choose a card
                        game.choose(card)
                    }
            })
            
            HStack {
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                }
                
                Button {
//                    game.newGame()
                } label: {
                    Text("Deal 3 Cards")
                }
            }
        }
    }
}



struct CardView: View {
    private let card: SetGameViewModel.Card
    
    init(_ card: SetGameViewModel.Card) {
        self.card = card
    }
    
    var body: some View {
        
        
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                //TODO: add changes for if selected
                
                //TODO: show shapes as content
                
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
//                    Text(card.content).font(font(in: geometry.size))

            }
        })
    }
    
//    private func font(in size: CGSize) -> Font {
//        Font.system(size: min( size.width, size.height) * DrawingConstants.fontScale)
//    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
//        static let fontScale: CGFloat = 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
