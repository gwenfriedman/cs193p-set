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
    
    mutating func choose(_ card: Card) {
         
        
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}) {
            dealtCards[chosenIndex].isSelected = true
            
            let selectedCards = dealtCards.filter { $0.isSelected }
            
            
            //When there are 3 cards selected
            if selectedCards.count == 3 {
                potentialMatchingCards = selectedCards
                let isSet = checkSet(potentialMatchingCards)
                
                //Turn yellow if match
                if isSet {
                    for c in selectedCards {
                        dealtCards.indices.forEach({
                            if dealtCards[$0].id == c.id {
                                dealtCards[$0].isMatched = Match.match
                            }
                        })
                        
                    }
                    
                    //turn black if not match

                } else {
                    
                    for c in selectedCards {
                        dealtCards.indices.forEach({
                            if dealtCards[$0].id == c.id {
                                dealtCards[$0].isMatched = Match.notMatch
                            }
                        })
                        
                    }
                    
                }
                
                //When there are 4 cards selected

            } else if selectedCards.count == 4 {
                let isSet = checkSet(potentialMatchingCards)


                //if is match, replace cards at index
                if isSet {
                    for c in potentialMatchingCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0].id == c.id {
                                    dealtCards.remove(at: $0)
                                    dealtCards.insert(cards.first!, at: $0)
                                    cards.removeFirst()
                                }
                            })

                    }

                    //if not match, deselect, dematch
                } else {
                    for c in potentialMatchingCards {
                            dealtCards.indices.forEach({
                                if dealtCards[$0].id == c.id {
                                    dealtCards[$0].isSelected = false
                                    dealtCards[$0].isMatched = Match.none
                                }
                            })

                    }
                }
                
                
            //de select a card
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
        
        //TODO: something is causing bugs! sometimes the cards values are not what they look like
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
