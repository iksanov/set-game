//
//  PlaygroundView.swift
//  SetGame
//
//  Created by MacBookPro on 25/01/2019.
//  Copyright © 2019 Iksanov. All rights reserved.
//

import UIKit

@IBDesignable
class PlaygroundView: UIView {
    
    // TODO: try to remove this function call
    // it can be removed if "Content mode" in storyboard is set to "Redraw"
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    @IBInspectable
    var numberOfCardsOnTheTable = 1
    
    lazy var grid = Grid(layout: .aspectRatio(SizeRatio.cardAspectRatio), frame: bounds)
    
    override func draw(_ rect: CGRect) {
        // TODO: try to remove this line
        super.setNeedsDisplay()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 50, startAngle: CGFloat.pi, endAngle: 1/2*CGFloat.pi, clockwise: true)
        path.stroke()
        
        // TODO: set background color in initializer
        // (don't know how)
        for ind in subviews.indices {
            subviews[ind].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    @objc func foo(arg: UITapGestureRecognizer) {
        print(arg.view!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // TODO: No need to delete all subviews everytime
        // it's enough to replace when the number of them didn't changed
        // even if it did their grid layout can remain the same
        while !subviews.isEmpty {
            subviews.first?.removeFromSuperview()
        }
        
        grid.frame = bounds
        grid.cellCount = numberOfCardsOnTheTable
        
        for i in 0..<numberOfCardsOnTheTable {
            if let newCardFrame = grid[i] {
                let newCard = SetCardView()
                let shortenFrame = newCardFrame.zoom(by: SizeRatio.cardWithInsetZoomedBy)
                newCard.frame = shortenFrame
                let tap = UITapGestureRecognizer(target: self, action: #selector(foo(arg:)))
                newCard.addGestureRecognizer(tap)
                
                addSubview(newCard)
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
