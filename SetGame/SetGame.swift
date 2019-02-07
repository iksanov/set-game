//
//  SetGame.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import Foundation

struct SetGame {
    var buttonIndices: Set<Int>
    var deckOfCards: [Card]
    var cardsOnTheTable: [Card]
    var selectedCards: [Card]
    
    var scoreCounter: Int
    
    private func ifNumbersEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.numberOfItems == card2.numberOfItems) && (card2.numberOfItems == card3.numberOfItems)
    }
    
    private func ifSymbolsEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.symbol == card2.symbol) && (card2.symbol == card3.symbol)
    }
    
    private func ifShadesEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.shade == card2.shade) && (card2.shade == card3.shade)
    }
    
    private func ifColorsEqualIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.color == card2.color) && (card2.color == card3.color)
    }
    
    private func ifNumbersAllDifferentIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.numberOfItems != card2.numberOfItems) && (card1.numberOfItems != card3.numberOfItems) && (card2.numberOfItems != card3.numberOfItems)
    }
    
    private func ifSymbolsAllDifferentIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.symbol != card2.symbol) && (card1.symbol != card3.symbol) && (card2.symbol != card3.symbol)
    }
    
    private func ifShadesAllDifferentIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.shade != card2.shade) && (card1.shade != card3.shade) && (card2.shade != card3.shade)
    }
    
    private func ifColorsAllDifferentIn(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        return (card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color)
    }
    
    var successfulMatch: Bool {
        if selectedCards.count == 3 {
            let (card1, card2, card3) = selectedCards.getFirstThree()
            let cond1 = ifNumbersEqualIn(card1, card2, card3) || ifNumbersAllDifferentIn(card1, card2, card3)
            let cond2 = ifSymbolsEqualIn(card1, card2, card3) || ifSymbolsAllDifferentIn(card1, card2, card3)
            let cond3 = ifShadesEqualIn(card1, card2, card3) || ifShadesAllDifferentIn(card1, card2, card3)
            let cond4 = ifColorsEqualIn(card1, card2, card3) || ifColorsAllDifferentIn(card1, card2, card3)
            return cond1 && cond2 && cond3 && cond4
        } else {
            assert(false)  // we can check successful match only for 3 selected cards
            print("The number of selected cards is != 3")
        }
    }
    
    mutating func addThreeCards() {
        if selectedCards.count == 3 && successfulMatch {
            scoreCounter += 3
            replaceSelectedCardsOnTableFromDeck()
            deselectAllCards()
        } else {
            for _ in 1...3 {
                let newCard = deckOfCards.removeLast()
                cardsOnTheTable.append(newCard)
            }
        }
    }
    
    mutating func reshuffle() {
        cardsOnTheTable.shuffle()
    }
    
    mutating func cardWasTouched(_ touchedCard: Card) {
        if selectedCards.count == 3 {
            if successfulMatch {
                scoreCounter += 3
                if !deckOfCards.isEmpty {
                    replaceSelectedCardsOnTableFromDeck()
                } else {
                    removeSelectedCardsFromTable()
                }
                let touchedCardIsSelected = selectedCards.contains(touchedCard)
                deselectAllCards()
                if !touchedCardIsSelected {
                    select(card: touchedCard)
                }
            } else {
                scoreCounter -= 5
                deselectAllCards()
                select(card: touchedCard)
            }
        } else {
            if selectedCards.contains(touchedCard) {
                scoreCounter -= 1
                deselect(card: touchedCard)
            } else {
                select(card: touchedCard)
            }
        }
    }
    
    private mutating func replaceSelectedCardsOnTableFromDeck() {
        for card in selectedCards {
            guard let index = cardsOnTheTable.firstIndex(of: card) else { assert(false) }
            cardsOnTheTable.remove(at: index)
            
            let newCard = deckOfCards.removeLast()
            cardsOnTheTable.insert(newCard, at: index)
        }
    }
    
    private mutating func removeSelectedCardsFromTable() {
        for card in selectedCards {
            guard let index = cardsOnTheTable.firstIndex(of: card) else { assert(false) }
            cardsOnTheTable.remove(at: index)
        }
    }
    
    private mutating func deselectAllCards() {
        selectedCards.removeAll()
    }
    
    private mutating func select(card: Card) {
        selectedCards.append(card)
    }
    
    private mutating func deselect(card: Card) {
        guard let index = selectedCards.firstIndex(of: card) else { assert(false) }
        selectedCards.remove(at: index)
    }
    
    init() {
        buttonIndices = Set(0..<24)
        deckOfCards = [Card]()
        cardsOnTheTable = [Card]()
        selectedCards = [Card]()
        scoreCounter = 0
        
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

extension Array {
    func getFirstThree() -> (Element, Element, Element) {
        let firstThreeSubrange = self.prefix(upTo: 3)
        return (firstThreeSubrange[0], firstThreeSubrange[1], firstThreeSubrange[2])
    }
}

