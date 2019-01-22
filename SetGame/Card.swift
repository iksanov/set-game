//
//  Card.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import Foundation

enum ColorOfCard {
    case red
    case green
    case purple
    
    static var all = [ColorOfCard.red, .green, .purple]
}

enum ShapeOfCard {
    case triangle
    case circle
    case square
    
    static var all = [ShapeOfCard.triangle, .circle, .square]
}

enum ShadeOfCard {
    case open
    case striped
    case solid
    
    static var all = [ShadeOfCard.open, .striped, .solid]
}

class Card {
    let color: ColorOfCard
    let shape: ShapeOfCard
    let shade: ShadeOfCard
    let numberOfItems: Int
    
    init(color: ColorOfCard, shape: ShapeOfCard, shade: ShadeOfCard, numberOfItems: Int) {
        self.color = color
        self.shape = shape
        self.shade = shade
        self.numberOfItems = numberOfItems
    }
}

