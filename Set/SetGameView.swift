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
            AspectVGrid(items: game.dealtCards, aspectRatio: 2/3, content: { card in
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
                    game.dealCards()
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
    
    var symbol: some View {
        Group {
            if card.shape == "diamond" {
                if card.shading == "outlined" {
                    Diamond()
                        .stroke(lineWidth: 3)
                }
                else {
                    Diamond()
                        .fill()
                }
            }
            if card.shape == "oval" {
                if card.shading == "outlined" {
                    Circle()
                        .stroke(lineWidth: 3)
                }
                else {
                    Circle()
                        .fill()
                }
            }
            if card.shape == "rectangle" {
                if card.shading == "outlined" {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 3)
                }
                else {
                    RoundedRectangle(cornerRadius: 5)
                        .fill()
                }
            }
        }
        .aspectRatio(2/1, contentMode: .fit)
    }
    
    var cardColor: Color {
        switch card.color {
            case "red":
                return Color.red
            case "purple":
                return Color.purple
            case "green":
                return Color.green
            default:
                return Color.black
        }
    }

    var opacity: Double {
        card.shading == "stripped" ? 0.3 : 1.0
    }
    
    var outlineColor: Color {
        card.isSelected ? Color.yellow : Color.black
    }
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                //TODO: add changes for if selected
                                
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(outlineColor, lineWidth: DrawingConstants.lineWidth)

                VStack {
                    ForEach(0..<card.number) { _ in
                            self.symbol
                        }
                    }
                .padding(8)
                .opacity(opacity)
            }
            .foregroundColor(cardColor)
        })
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
