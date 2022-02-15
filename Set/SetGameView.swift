//
//  ContentView.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()
    
    @State private var discarded = Set<Int>()
        
    private func deal(_ card: SetGameViewModel.Card) {
        dealt.insert(card.id)
    }
    
    private func discard(_ card: SetGameViewModel.Card) {
        discarded.insert(card.id)
    }
    
    private func isUndealt(_ card: SetGameViewModel.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func isDiscarded(_ card: SetGameViewModel.Card) -> Bool {
        discarded.contains(card.id)
    }
    
    private func dealAnimation(for card: SetGameViewModel.Card, index: Int) -> Animation {
        let delay = Double(index) * 1.0 / 3.0
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    private func discardAnimation(for card: SetGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.dealtCards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalDealDuration / Double(game.dealtCards.count)
        }
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack{
                gameBody
                newGame
                .padding(.horizontal)
            }
                        
            HStack {
                deckBody
                Spacer()
                discardBody
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.dealtCards, aspectRatio: 2/3, content: { card in
            CardView(card, isFaceUp: true)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
//                .zIndex(1)
                .onTapGesture {
                    //Intent to choose a card
                    print("choose")
                    withAnimation {
                        game.choose(card)
                    }
                }
        })
    }
    
    
    //TODO: animate adding cards
    var deckBody: some View {
        ZStack {
            
            //TODO: for some reason this is adding an extra card at each spot
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card, isFaceUp: false)
//                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
//                    .zIndex(0.01)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        
        .onTapGesture {
            // "deal" cards
            let dealtCards = game.dealCards()
            for i in dealtCards.indices {
                withAnimation(dealAnimation(for: dealtCards[i], index: i)) {
                    deal(dealtCards[i])
                }
            }
        }
    }
    
    var discardBody: some View {
        ZStack {
            ForEach(game.discardedCards) { card in
                CardView(card, isFaceUp: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    var newGame: some View {
        Button("New Game") {
            dealt = []
            game.dealtCards.forEach { card in
                dealt.insert(card.id)
            }
            game.newGame()
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
        static let totalDealDuration: Double = 3
    }
}



//TODO: add cardify?

struct CardView: View {
    private let card: SetGameViewModel.Card
    private var isFaceUp: Bool = true
    
    init(_ card: SetGameViewModel.Card, isFaceUp: Bool) {
        self.card = card
        self.isFaceUp = isFaceUp
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
    
    //TODO: animate matches and not matches
    var cardBackgroundColor: Color {
        switch card.isMatched {
            case .notMatch:
                return Color.black
            
            case .match:
                return Color.yellow
            
            case .none:
                return Color.white
            
        }
    }
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                                                
                shape.fill().foregroundColor(isFaceUp ? cardBackgroundColor : .red)
                    shape.strokeBorder(outlineColor, lineWidth: DrawingConstants.lineWidth)

                if isFaceUp {
                    VStack {
                        ForEach(0..<card.numberOfShapes) { _ in
                                symbol
                            }
                        }
                    .padding(8)
                    .opacity(opacity)
                }
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
