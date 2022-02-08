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
    private(set) var dealtCards: Array<Card> = []
    
    
    
    mutating func choose(_ card: Card) {
         
        
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}) {
            
            let selectedCards = dealtCards.filter { $0.isSelected }
            
            
            if selectedCards.count == 3 {
                
                let isSet = checkSet(selectedCards)
                
                //if is match, replace cards at index
                if isSet {
                    for c in selectedCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0] == c {
                                    dealtCards.remove(at: $0)
                                    dealtCards.insert(cards.first!, at: $0)
                                    cards.removeFirst()
                                }
                            })
                        
                    }
                    dealtCards[chosenIndex].isSelected = true
                    
                } else {
                    for c in selectedCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0] == c {
                                    dealtCards[$0].isSelected = false
                                }
                            })
                        
                    }
                    dealtCards[chosenIndex].isSelected = true
                }
                
                            
                //what to do if there are no cards left?
                
                //if not a match - deselect all? - need to tell user!
                
                
                //TODO: deselect
                
            } else if card.isSelected {
                //TODO: this doesn't work! doesn't update the view
                print(card, dealtCards[chosenIndex])
                dealtCards[chosenIndex].isSelected = false
                print(card, dealtCards[chosenIndex])
            
            } else {
            
                dealtCards[chosenIndex].isSelected = true
                
            }
        }
    }
    
    
    private func checkSet(_ cards: [Card]) -> Bool {
                
        var features = [AnyHashable:Int]()
        for c in cards {
            features[c.number, default: 0] += 1
            features[c.color, default: 0] += 1
            features[c.shading, default: 0] += 1
            features[c.shape, default: 0] += 1
        }
                
//        if isMatch {
//            for index in cards {
//                dealtCards[index].isMatched = true
//            }
//        }

        return features.filter { $0.value == 2}.isEmpty ? true : false
        
    }
    
    mutating func dealCards() {
        if cards.count == 0 {
            print("no more cards in deck")
        } else {
            dealtCards.append(contentsOf: cards[0...2])
            cards.removeSubrange(0...2)
        }
    }
    
    init(numbers: [Int], colors: [String], shapeTypes: [String], shadings: [String]) {
        cards = []
        
        for number in numbers {
            for color in colors {
                for shape in shapeTypes {
                    for shading in shadings {
                        cards.append(Card(color: color, shape: shape, number: number, shading: shading))
                    }
                }
            }
        }
        
        cards.shuffle()
        
        dealtCards.append(contentsOf: cards[0...11])
        
        cards.removeSubrange(0...11)
    }
    
    
    struct Card: Identifiable, Equatable, Hashable {
        let color: String
        let shape: String
        let number: Int
        let shading: String
        var isSelected = false
//        var isMatched = false
        
        let id = UUID()
    }
    
}
