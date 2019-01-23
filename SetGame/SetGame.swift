//
//  SetGame.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import Foundation

extension Array {
    func getFirstThree() -> (Element, Element, Element) {
        let firstThreeSubrange = self.prefix(upTo: 3)
        return (firstThreeSubrange[0], firstThreeSubrange[1], firstThreeSubrange[2])
    }
}

struct SetGame {
    var buttonIndices = Set(0..<24)
    var deckOfCards = [Card]()
    var cardsOnTheTable = [Card]()
    var selectedCards = [Card]()
    
    func ifNumbersEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.numberOfItems == card2.numberOfItems) && (card2.numberOfItems == card3.numberOfItems)
    }
    
    func ifSymbolsEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.symbol == card2.symbol) && (card2.symbol == card3.symbol)
    }
    
    func ifShadesEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.shade == card2.shade) && (card2.shade == card3.shade)
    }
    
    func ifColorsEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.color == card2.color) && (card2.color == card3.color)
    }
    
    var successfulMatch: Bool {
        if selectedCards.count == 3 {
            let (card1, card2, card3) = selectedCards.getFirstThree()
            let cond1 = ifNumbersEqualIn(card1, card2, card3)
            let cond2 = ifSymbolsEqualIn(card1, card2, card3)
            let cond3 = ifShadesEqualIn(card1, card2, card3)
            let cond4 = ifColorsEqualIn(card1, card2, card3)
            return cond1 && cond2 && cond3 && cond4
        } else {
            assert(false)  // we can check successful match only for 3 selected cards
            print("The number of selected cards is != 3")
        }
//         return true
    }
    
    init() {
        for color in ColorOfCard.all {
            for symbol in SymbolOfCard.all {
                for shade in ShadeOfCard.all {
                    for number in 1...3 {
                        let card: Card = Card(color: color, symbol: symbol, shade: shade, numberOfItems: number)
                        deckOfCards.append(card)
                    }
                }
            }
        }
        deckOfCards.shuffle()
        for _ in 1...12 {
            let card = deckOfCards.removeLast()
            card.buttonIndex = buttonIndices.removeFirst()
            cardsOnTheTable.append(card)
        }
    }
}


