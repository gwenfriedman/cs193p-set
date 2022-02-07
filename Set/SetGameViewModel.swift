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
        SetGame<String>()
    }
    
    typealias Card = SetGame<String>.Card

    
    @Published private var model = createSetGame(theme: themes[0])
    
    private(set) var theme: Theme
    
    init() {
            theme = SetGameViewModel.themes[0]
            model = SetGameViewModel.createSetGame(theme: theme)
        }
        
    static var themes: [Theme] = [
        Theme(name: "classic", shapes: ["rectangle", "circle", "diamond"], colors: ["red", "blue", "green"])
    ]
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func newGame() -> Void {
        theme = SetGameViewModel.themes[0]
        model = SetGameViewModel.createSetGame(theme: theme)
    }
    
    var themeName: String {
        theme.name
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    
}
