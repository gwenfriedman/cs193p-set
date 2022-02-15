//
//  SetGame.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import Foundation


//Model

struct SetGame<CardContent> where CardContent: Equatable  {
    //All Cards
    private(set) var cards: Array<Card> = []
    
    //Deck
    private(set) var deck: Array<Card> = []
    
    //dealt cards (face up, on screen)
    private(set) var dealtCards: Array<Card> = []
    
    //Discarded cards
    private(set) var discardedCards: Array<Card> = []
    
    private(set) var potentialMatchingCards: Array<Card> = []
    
    init(numberOfShapes: [Int], colors: [String], shapeTypes: [String], shadings: [String], numberOfCards: Int) {
        reset(numberOfShapes: numberOfShapes, colors: colors, shapeTypes: shapeTypes, shadings: shadings)
        dealCards(numberOfCards)
    }
    
    mutating func choose(_ card: Card) {
        
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}) {
            dealtCards[chosenIndex].isSelected = true
            
            let selectedCards = dealtCards.filter { $0.isSelected }
            
            
            //When there are 3 cards selected
            if selectedCards.count == 3 {
                potentialMatchingCards = selectedCards
                print("potentialMatchingCards", potentialMatchingCards)
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


                //if is match, remove cards
                if isSet {
                    for c in potentialMatchingCards {
                        
                        dealtCards.indices.forEach({
                            if dealtCards[$0].id == c.id {
                                
                                dealtCards[$0].isSelected = false
                                dealtCards[$0].isMatched = Match.none
                                
                                discardedCards.append(dealtCards.remove(at: $0))

                                dealtCards.insert(deck.first!, at: $0)
                                deck.removeFirst()
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
            features[c.numberOfShapes, default: 0] += 1
            features[c.color, default: 0] += 1
            features[c.shading, default: 0] += 1
            features[c.shape, default: 0] += 1
        }
        
        //TODO: something is causing bugs! sometimes the cards values are not what they look like
        return features.filter { $0.value == 2}.isEmpty ? true : false
        
    }
    
    mutating func dealCards(_ numberOfCards: Int) -> Array<Card> {
        var dealtNow: Array<Card> = []
        for _ in 0..<numberOfCards {
            if !deck.isEmpty {
                let c = deck.remove(at: 0)
                dealtNow.append(c)
                dealtCards.append(c)
            } else {
                print("no more cards in deck")
            }
        }
        return dealtNow
    }
    
    mutating func reset(numberOfShapes: [Int], colors: [String], shapeTypes: [String], shadings: [String]) {
        cards = []
        var id = 0
        
        for number in numberOfShapes {
            for color in colors {
                for shape in shapeTypes {
                    for shading in shadings {
                        cards.append(Card(color: color, shape: shape, numberOfShapes: number, shading: shading, isMatched: Match.none, id: id))
                        id += 1
                    }
                }
            }
        }
        
        cards.shuffle()
        deck = cards
        
        dealtCards = []
        discardedCards = []
        potentialMatchingCards = []
    }
    
    
    struct Card: Identifiable, Equatable, Hashable {
        
        let color: String
        let shape: String
        let numberOfShapes: Int
        let shading: String
        var isSelected = false
        var isMatched: Match = Match.none
        
        let id: Int
    }
    
    enum Match: String, Hashable {
        case match
        case notMatch
        case none
    }
    
}
