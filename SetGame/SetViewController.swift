//
//  ViewController.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        everything works without the following line
//        super.traitCollectionDidChange(previousTraitCollection)
        view.layoutIfNeeded()
        updateViewFromModel()
    }
    
    var game = SetGame()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
    }
    
    @IBOutlet weak var dealCardsButton: UIButton!
    
    @IBAction func DealThreeMoreCards(_ sender: UIButton) {
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func changeCardAspectRatio() {
        for card in cardButtons {
            let cardAspectRatioConstraint = NSLayoutConstraint(
                item: card,
                attribute: .width,
                relatedBy: .equal,
                toItem: card,
                attribute: .height,
                multiplier: 8 / 17,
                constant: 0)
            card.addConstraint(cardAspectRatioConstraint)
        }
    }
    
    func colorFromEnum(color: ColorOfCard) -> UIColor {
        switch color {
        case .green: return #colorLiteral(red: 0, green: 0.6498066187, blue: 0.2595749497, alpha: 1)
        case .purple: return #colorLiteral(red: 0.6721233726, green: 0.1548318267, blue: 0.6646618247, alpha: 1)
        case .red: return #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
        }
    }
    
    func itemShapeFromEnum(shape: ShapeOfCard) -> String {
        switch shape {
        case .triangle: return "\u{25B2}"
        case .circle: return "\u{25CF}"
        case .square: return "\u{25A0}"
        }
    }
    
    func titleForCard(_ card: Card) -> String {
        let stringArray = Array(repeating: itemShapeFromEnum(shape: card.shape), count: card.numberOfItems)
        return stringArray.joined(separator: "\n")
    }
    
    func createAttributedString(for card: Card, withFontSize fontSize: CGFloat) -> NSAttributedString {
        UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let color = colorFromEnum(color: card.color)
        return NSAttributedString(string: titleForCard(card), attributes: [.font : font, .foregroundColor : color])
    }
    
    func wellSizedTitleString(for card: Card) -> NSAttributedString {
        let verticalRowSpacing = CGFloat(cardButtons[0].bounds.size.height / 3.0)
        let attemptedTitleString = createAttributedString(for: card, withFontSize: verticalRowSpacing)
        let probablyOkayTitleStringFontSize = verticalRowSpacing / ((attemptedTitleString.size().height / CGFloat(card.numberOfItems)) / verticalRowSpacing)
        let probablyOkayTitleString = createAttributedString(for: card, withFontSize: probablyOkayTitleStringFontSize)
        if probablyOkayTitleString.size().width > cardButtons[0].bounds.size.width {
            return createAttributedString(for: card, withFontSize: probablyOkayTitleStringFontSize / (probablyOkayTitleString.size().width / cardButtons[0].bounds.size.width))
        } else {
            return probablyOkayTitleString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in cardButtons.indices {
            cardButtons[index].titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        dealCardsButton.titleLabel?.textAlignment = NSTextAlignment.center
        dealCardsButton.setTitle("Deal 3\nMore Cards", for: UIControl.State.normal)
        dealCardsButton.titleLabel?.numberOfLines = 2
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            cardButtons[index].setTitle("", for: UIControl.State.normal)
        }
        for index in game.cardsOnTheTable.indices {
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0.6, alpha: 1)
            let buttonTitleString = wellSizedTitleString(for: game.cardsOnTheTable[index])
            cardButtons[index].setAttributedTitle(buttonTitleString, for: UIControl.State.normal)
        }
    }
}
