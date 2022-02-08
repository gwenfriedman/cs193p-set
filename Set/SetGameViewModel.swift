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
        SetGame<String>(numbers: theme.numbers, colors: theme.colors, shapeTypes: theme.shapes, shadings: theme.shadings)
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
    
    var dealtCards: Array<Card> {
        return model.dealtCards
    }
    
    func newGame() -> Void {
        theme = SetGameViewModel.themes[0]
        model = SetGameViewModel.createSetGame(theme: theme)
    }
    
    func dealCards() -> Void {
        model.dealCards()
    }
    
    var themeName: String {
        theme.name
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
