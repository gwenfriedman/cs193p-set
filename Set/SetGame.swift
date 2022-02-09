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
    
    private(set) var potentialMatchingCards: Array<Card> = []
    
    private(set) var hasMatch: Bool = false
    
    
    
    mutating func choose(_ card: Card) {
         
        
        //TODO: check case when no cards left
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}) {
            dealtCards[chosenIndex].isSelected = true
            
            let selectedCards = dealtCards.filter { $0.isSelected }
            print("selected cards!", selectedCards)
                                                
            if selectedCards.count == 3 {
                hasMatch = checkSet(selectedCards)
                potentialMatchingCards = selectedCards
                
                
                if hasMatch {
                    //Is set and is match
                    for c in selectedCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0] == c {
                                    dealtCards[$0].isMatched = Match.match
                                }
                            })
                    }
                } else {
                    //is not set and is not match
                    for c in selectedCards {
                        dealtCards.indices.forEach({
                            if dealtCards[$0] == c {
                                dealtCards[$0].isMatched = Match.notMatch
                            }
                        })
                    }
                }
            }
            
            if selectedCards.count == 4 {
                //if is match, replace cards at index
                if hasMatch {
                    //already has set and selects another card
                    for c in potentialMatchingCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0].id == c.id {
                                    dealtCards.remove(at: $0)
                                    dealtCards.insert(cards.first!, at: $0)
                                    cards.removeFirst()
                                }
                            })
                        
                    }
                    
                    potentialMatchingCards = []
                    
                    
                } else {
                    //is not set, deselect and change match to none
                    for c in potentialMatchingCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0].id == c.id {
                                    dealtCards[$0].isSelected = false
                                    dealtCards[$0].isMatched = Match.none
                                }
                            })
                        
                    }
                    
                    potentialMatchingCards = []
                }
                
            } else if card.isSelected {
                dealtCards[chosenIndex].isSelected = false
            }
        }
    }
    
    
    private func checkSet(_ cards: [Card]) -> Bool {
                
        var features = [AnyHashable:Int]()
        for c in cards {
            features[c.numberofShapes, default: 0] += 1
            features[c.color, default: 0] += 1
            features[c.shading, default: 0] += 1
            features[c.shape, default: 0] += 1
        }
        print(features.filter { $0.value == 2}.isEmpty ? true : false, features, cards)
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
    
    init(numberofShapes: [Int], colors: [String], shapeTypes: [String], shadings: [String]) {
        cards = []
        
        for number in numberofShapes {
            for color in colors {
                for shape in shapeTypes {
                    for shading in shadings {
                        cards.append(Card(color: color, shape: shape, numberofShapes: number, shading: shading, isMatched: Match.none))
                    }
                }
            }
        }
        
        cards.shuffle()
        
        dealtCards.append(contentsOf: cards[0...11])
        print("dealtCards", dealtCards)
        
        cards.removeSubrange(0...11)
    }
    
    
    struct Card: Identifiable, Equatable, Hashable {
        
        let color: String
        let shape: String
        let numberofShapes: Int
        let shading: String
        var isSelected = false
        var isMatched: Match = Match.none
        
        let id = UUID()
    }
    
    enum Match: String, Hashable {
        case match
        case notMatch
        case none
    }
    
}
