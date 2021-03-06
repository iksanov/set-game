//
//  SetCardView.swift
//  SetGame
//
//  Created by MacBookPro on 24/01/2019.
//  Copyright © 2019 Iksanov. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    init(color: ColorOfCard, symbol: SymbolOfCard, shade: ShadeOfCard, numberOfItems: Int, selected: Bool = false, successful: Bool = false, unsuccessful: Bool = false) {
        self.color = color
        self.symbol = symbol
        self.shade = shade
        self.numberOfItems = numberOfItems
        self.selected = selected
        self.successful = successful
        self.unsuccessful = unsuccessful
        
        super.init(frame: CGRect.init())
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var color: ColorOfCard
    var symbol: SymbolOfCard
    var shade: ShadeOfCard
    var numberOfItems: Int
    var selected: Bool
    var successful: Bool
    var unsuccessful: Bool
    
    private func colorFromEnum(color: ColorOfCard) -> UIColor {
        switch color {
        case .green: return #colorLiteral(red: 0, green: 0.6498066187, blue: 0.2595749497, alpha: 1)
        case .purple: return #colorLiteral(red: 0.6721233726, green: 0.1548318267, blue: 0.6646618247, alpha: 1)
        case .red: return #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
        }
    }
    
    private func stripeItemsWith(paths itemPaths: [UIBezierPath]) {
        if let context = UIGraphicsGetCurrentContext() {
            for path in itemPaths {
                context.saveGState()
                path.addClip()
                stripe(rect: bounds)
                context.restoreGState()
            }
        }
    }
    
    private func stripe(rect: CGRect) {
        let pathForStripes = UIBezierPath()
        for x in stride(from: rect.origin.x, through: rect.maxX, by: strideWidth) {
            pathForStripes.move(to: CGPoint(x: x, y: rect.origin.y))
            pathForStripes.addLine(to: CGPoint(x: x, y: rect.origin.y + rect.size.height))
        }
        let cardColor = colorFromEnum(color: color)
        cardColor.withAlphaComponent(ColorConstants.alphaForStripes).setStroke()
        pathForStripes.stroke()
    }
    
    private func itemPathWithYCoord(_ YCoord: CGFloat) -> UIBezierPath {
        let rectForItem = CGRect.withCenterAndSize(center: CGPoint(x: bounds.center.x, y: YCoord), size: itemSize)
        let itemPath = itemInRect(rectForItem)
        return itemPath
    }
    
    private func createItems() -> [UIBezierPath] {
        var itemPaths = [UIBezierPath]()
        switch numberOfItems {
        case 1:
            let itemPath = itemPathWithYCoord(bounds.center.y)
            itemPaths.append(itemPath)
            return itemPaths
        case 2:
            let itemPath_upper = itemPathWithYCoord(upperOfTwoItemYCoord)
            let itemPath_lower = itemPathWithYCoord(lowerOfTwoItemYCoord)
            itemPaths.append(contentsOf: [itemPath_upper, itemPath_lower])
            return itemPaths
        case 3:
            let itemPath_upper = itemPathWithYCoord(upperOfThreeItemYCoord)
            let itemPath_mid = itemPathWithYCoord(bounds.center.y)
            let itemPath_lower = itemPathWithYCoord(LowerOfThreeItemYCoord)
            itemPaths.append(contentsOf: [itemPath_upper, itemPath_mid, itemPath_lower])
            return itemPaths
        default:
            assert(false, "inappropriate number of items on card")
        }
    }
    
    
    
    private func pathForSquiggleFor(rect: CGRect) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        func addCurveToPathWithOffsetConsts(destWidthConst: CGFloat, destHeightConst: CGFloat,
                                            cp1WidthConst: CGFloat, cp1HeightConst: CGFloat,
                                            cp2WidthConst: CGFloat, cp2HeightConst: CGFloat) {
            
            path.addCurve(to: CGPoint(x: rect.origin.x + rect.size.width * destWidthConst, y: rect.origin.y + rect.size.height * destHeightConst),
                          controlPoint1: CGPoint(x: rect.origin.x + rect.size.width * cp1WidthConst, y: rect.origin.y + rect.size.height * cp1HeightConst),
                          controlPoint2: CGPoint(x: rect.origin.x + rect.size.width * cp2WidthConst, y: rect.origin.y + rect.size.height * cp2HeightConst))
        }
        
        path.move(to: CGPoint(x: rect.origin.x + rect.size.width * 0.05, y: rect.origin.y + rect.size.height * 0.40))
        addCurveToPathWithOffsetConsts(destWidthConst: 0.35, destHeightConst: 0.25, cp1WidthConst: 0.1, cp1HeightConst: 0.2, cp2WidthConst: 0.18, cp2HeightConst: 0.10)
        addCurveToPathWithOffsetConsts(destWidthConst: 0.75, destHeightConst: 0.30, cp1WidthConst: 0.40, cp1HeightConst: 0.30, cp2WidthConst: 0.60, cp2HeightConst: 0.45)
        addCurveToPathWithOffsetConsts(destWidthConst: 0.97, destHeightConst: 0.35, cp1WidthConst: 0.87, cp1HeightConst: 0.15, cp2WidthConst: 0.98, cp2HeightConst: 0.00)
        addCurveToPathWithOffsetConsts(destWidthConst: 0.45, destHeightConst: 0.85, cp1WidthConst: 0.95, cp1HeightConst: 1.10, cp2WidthConst: 0.50, cp2HeightConst: 0.95)
        addCurveToPathWithOffsetConsts(destWidthConst: 0.25, destHeightConst: 0.85, cp1WidthConst: 0.40, cp1HeightConst: 0.80, cp2WidthConst: 0.35, cp2HeightConst: 0.75)
        addCurveToPathWithOffsetConsts(destWidthConst: 0.05, destHeightConst: 0.40, cp1WidthConst: -0.10, cp1HeightConst: 1.25, cp2WidthConst: 0.00, cp2HeightConst: 0.60)
        return path
    }
    
    private func itemInRect(_ rectForItem: CGRect) -> UIBezierPath {
        switch symbol {
        case .oval:
            let itemPath = UIBezierPath(roundedRect: rectForItem, cornerRadius: itemCornerRadius)
            return itemPath
        case .diamond:
            let itemPath = UIBezierPath()
            itemPath.move(to: CGPoint(x: rectForItem.origin.x, y: rectForItem.origin.y + rectForItem.size.height / 2))
            itemPath.addLine(to: CGPoint(x: rectForItem.origin.x + rectForItem.size.width / 2, y: rectForItem.origin.y +  rectForItem.size.height))
            itemPath.addLine(to: CGPoint(x: rectForItem.origin.x + rectForItem.size.width, y: rectForItem.origin.y + rectForItem.size.height / 2))
            itemPath.addLine(to: CGPoint(x: rectForItem.origin.x + rectForItem.size.width / 2, y: rectForItem.origin.y))
            itemPath.close()
            return itemPath
        case .squiggle:
            return pathForSquiggleFor(rect: rectForItem)
        }
    }
    
    private func colorItemsWith(paths itemPaths: [UIBezierPath]) {
        let itemColor = colorFromEnum(color: color)
        itemColor.setFill()
        itemColor.setStroke()
        for path in itemPaths {
            switch shade {
            case .open, .striped:
                path.stroke()
            case .solid:
                path.fill()
            }
        }
        if shade == .striped {
            stripeItemsWith(paths: itemPaths)
        }
    }
    
    override func draw(_ rect: CGRect) {
        colorCard()
        
        let itemsPaths = createItems()
        colorItemsWith(paths: itemsPaths)
        
        colorBordersIfNeeded()
    }
    
    private func colorCard() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
        #colorLiteral(red: 0.9764705882, green: 0.8392156863, blue: 0.6862745098, alpha: 1).setFill()
        roundedRect.fill()
    }
    
    private func colorBordersIfNeeded() {
        let cardBorder = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
        cardBorder.lineWidth = SizeRatio.cardBorderWidth
        
        if unsuccessful {
            #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1).setStroke()
            cardBorder.stroke()
            return
        }
        if successful {
            #colorLiteral(red: 0.1898198426, green: 0.9772902131, blue: 0, alpha: 1).setStroke()
            cardBorder.stroke()
            return
        }
        if selected {
            #colorLiteral(red: 0, green: 0.5446566343, blue: 0.9828409553, alpha: 1).setStroke()
            cardBorder.stroke()
            return
        }
    }
}

extension CGRect {
    static func withCenterAndSize(center: CGPoint, size: CGSize) -> CGRect {
        return CGRect(origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), size: size)
    }
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

extension SetCardView {
    private struct SizeRatio {
        static let cardCornerRadiusToCardHeight: CGFloat = 0.05
        static let itemCornerRadiusToItemWidth: CGFloat = 0.3
        static let itemWidthToCardWidth: CGFloat = 0.7
        static let itemHeightToCardHeight: CGFloat = 0.13
        static let strideWidthToItemWidth: CGFloat = 0.05
        static let upperOfTwoItemYCoordToCardHeight: CGFloat = 0.3
        static let upperOfThreeItemYCoordToCardHeight: CGFloat = 0.2
        static let cardBorderWidth: CGFloat = 3.2
    }
    private struct ColorConstants {
        static let alphaForStripes: CGFloat = 0.5
    }
    private var cardCornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cardCornerRadiusToCardHeight
    }
    private var itemWidth: CGFloat {
        return bounds.size.width * SizeRatio.itemWidthToCardWidth
    }
    private var itemHeight: CGFloat {
        return bounds.size.height * SizeRatio.itemHeightToCardHeight
    }
    private var itemSize: CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
    private var itemCornerRadius: CGFloat {
        return itemWidth * SizeRatio.itemCornerRadiusToItemWidth
    }
    private var strideWidth: CGFloat {
        return itemWidth * SizeRatio.strideWidthToItemWidth
    }
    private var upperOfTwoItemYCoord: CGFloat {
        return bounds.size.height * SizeRatio.upperOfTwoItemYCoordToCardHeight + bounds.origin.y
    }
    private var lowerOfTwoItemYCoord: CGFloat {
        return bounds.size.height * (1 - SizeRatio.upperOfTwoItemYCoordToCardHeight) + bounds.origin.y
    }
    private var upperOfThreeItemYCoord: CGFloat {
        return bounds.size.height * SizeRatio.upperOfThreeItemYCoordToCardHeight + bounds.origin.y
    }
    private var LowerOfThreeItemYCoord: CGFloat {
        return bounds.size.height * (1 - SizeRatio.upperOfThreeItemYCoordToCardHeight) + bounds.origin.y
    }
}
