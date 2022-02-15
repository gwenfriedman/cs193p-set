//
//  SetGame.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import SwiftUI


//Model View
class SetGameViewModel : ObservableObject {
    
    private static func createSetGame(theme: Theme) -> SetGame<String> {
        SetGame<String>(numberOfShapes: theme.numbers, colors: theme.colors, shapeTypes: theme.shapes, shadings: theme.shadings, numberOfCards: 12)
    }
    
    typealias Card = SetGame<String>.Card

    
    @Published private var model = createSetGame(theme: themes[0])
    
    private(set) var theme: Theme
    
    init() {
            theme = SetGameViewModel.themes[0]
            model = SetGameViewModel.createSetGame(theme: theme)
        }
       
    static var themes: [Theme] = [
        Theme(name: "classic", shapes: ["rectangle", "oval", "diamond"], colors: ["red", "purple", "green"], numbers: [1, 2, 3], shadings: ["fill", "stripped", "outlined"])
    ]
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var deck: Array<Card> {
        return model.deck
    }
    
    var dealtCards: Array<Card> {
        return model.dealtCards
    }
    
    var discardedCards: Array<Card> {
        return model.discardedCards
    }
    
    func dealCards() -> Array<Card> {
        model.dealCards(3)
    }
    
    var themeName: String {
        theme.name
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = SetGameViewModel.themes[0]
        model = SetGameViewModel.createSetGame(theme: theme)
    }
}
