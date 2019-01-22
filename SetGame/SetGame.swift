//
//  SetGame.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import Foundation

struct SetGame {
    private(set) var deckOfCards = [Card]()
    var cardsOnTheTable = [Card]()
    var selectedCards = [Card]()
//    var successfulMatch: Bool {
//        if sele
//        return
//    }
    
    init() {
        for color in ColorOfCard.all {
            for shape in ShapeOfCard.all {
                for shade in ShadeOfCard.all {
                    for number in 1...3 {
                        let card: Card = Card(color: color, shape: shape, shade: shade, numberOfItems: number)
                        deckOfCards.append(card)
                    }
                }
            }
        }
        deckOfCards.shuffle()
        for _ in 1...12 {
            cardsOnTheTable.append(deckOfCards.removeLast())
        }
    }
}

