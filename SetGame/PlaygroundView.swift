//
//  PlaygroundView.swift
//  SetGame
//
//  Created by MacBookPro on 25/01/2019.
//  Copyright © 2019 Iksanov. All rights reserved.
//

import UIKit

class PlaygroundView: UIView {
    var numberOfCardsOnTheTable = -1
    
    lazy var grid = Grid(layout: .aspectRatio(SizeRatio.cardAspectRatio), frame: bounds)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        grid.frame = bounds
        grid.cellCount = numberOfCardsOnTheTable
        
        for i in 0..<numberOfCardsOnTheTable {
            if let newCardFrame = grid[i] {
                let cardView = subviews[i]
                let shortenFrame = newCardFrame.zoom(by: SizeRatio.cardWithInsetZoomedBy)
                cardView.frame = shortenFrame
            }
        }
    }
}

extension CGRect {
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newHeight = height * scale
        let newWidth = width * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension PlaygroundView {
    private struct SizeRatio {
        static let cardAspectRatio: CGFloat = 0.47
        static let cardWithInsetZoomedBy: CGFloat = 0.97
    }
}
