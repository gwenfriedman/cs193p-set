//
//  SetGame.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import Foundation


//Model

struct SetGame<CardContent> where CardContent: Equatable  {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        
        //add game logic
    }
    
    
    func checkMatch() {
        
    }
    
    init() {
        cards = []
                        
        for number in Number.allCases {
            for color in Color.allCases {
                for shape in ShapeType.allCases {
                    for shading in Shading.allCases {
                        cards.append(Card(color: color, shape: shape, number: number, shading: shading))
                    }
                }
            }
        }
        cards.shuffle()
        
        
        var remainingCardCount: Int {
             cards.count
         }
        
        
        func dealThreeCards() -> [Card]? {
            guard cards.count > 2 else {
                return nil
            }
//            return cards.removeFirst()
            //TODO: this might not be right
            return [cards[0], cards[1], cards[2]]
        }
    }
    
    
    
    struct Card: Identifiable {
        let color: Color
        let shape: ShapeType
        let number: Number
        let shading: Shading
        let selected = false
//        var isMatched = false
        
        let id = UUID()
    }
    
}

enum ShapeType: String, CaseIterable, Hashable {
    case oval, squiggle, diamond
}

enum Number: Int, CaseIterable, Hashable {
    case one = 1, two, three
}

enum Color: String, CaseIterable, Hashable {
    case red = "🟥", purple = "🟪", green = "🟩"
}

enum Shading: String, CaseIterable, Hashable {
    case solid, stripped, outlined
}
