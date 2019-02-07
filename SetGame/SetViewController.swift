//
//  ViewController.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    @objc func foo(arg: UITapGestureRecognizer) {
        if let viewThatWasTapped = arg.view {
            if let tappedIndex = playgroundView.subviews.firstIndex(of: viewThatWasTapped) {
                print(tappedIndex)
            } else {
                print("error in getting index of view in subviews array")
            }
        } else {
            print("error in accessing the tapped view itsekf")
        }
    }

    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
////        everything works without the following line
////        super.traitCollectionDidChange(previousTraitCollection)
//        view.layoutIfNeeded()
//        updateViewFromModel()
//    }
    
    @IBOutlet weak var playgroundView: PlaygroundView! {
        didSet {
            print("PLAYGROUNDVIEW_DIDSET")
            updateViewFromModel()
        }
    }

    private var game = SetGame()
    
    private func updateViewFromModel() {
        playgroundView.numberOfCardsOnTheTable = game.cardsOnTheTable.count
        
        // TODO: No need to delete all subviews everytime
        // it's enough to replace when the number of them didn't changed
        // even if it did their grid layout can remain the same
        while !playgroundView.subviews.isEmpty {
            playgroundView.subviews.first?.removeFromSuperview()
        }
        
        for card in game.cardsOnTheTable {
            let newCardView = SetCardView()
            newCardView.color = card.color
            newCardView.symbol = card.symbol
            newCardView.shade = card.shade
            newCardView.numberOfItems = card.numberOfItems
            
            if game.selectedCards.contains(card) {
                newCardView.selected = true
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(foo(arg:)))
            newCardView.addGestureRecognizer(tap)
            
            playgroundView.addSubview(newCardView)
        }
        
        if game.selectedCards.count == 3 {
            for selectedCard in game.selectedCards {
                guard let indexOfSelectedCard = game.cardsOnTheTable.firstIndex(of: selectedCard) else { return }
                guard let viewOfSelectedCard = playgroundView.subviews[indexOfSelectedCard] as? SetCardView else { return }
                if game.successfulMatch {
                    viewOfSelectedCard.successful = true
                } else {
                    viewOfSelectedCard.successful = false
                }
            }
        }
        
        playgroundView.layoutIfNeeded()
        
                if dealCardsButtonIsDisabled {
                    dealCardsButton.backgroundColor = #colorLiteral(red: 0.3272040486, green: 0.4194450378, blue: 0.8449910283, alpha: 1).withAlphaComponent(0.15)
                    dealCardsButton.isEnabled = false
                } else {
                    dealCardsButton.backgroundColor = #colorLiteral(red: 0.3272040486, green: 0.4194450378, blue: 0.8449910283, alpha: 1)
                    dealCardsButton.isEnabled = true
                }
                updateScoreLabel()
    }
    
    private var dealCardsButtonIsDisabled: Bool {
        get {
            return game.deckOfCards.isEmpty
        }
    }
    
//    private func cardByButton(_ button: UIButton) -> Card? {
//        if let cardIndex = cardButtons.firstIndex(of: button) {
//            if let card = game.cardsOnTheTable.first(where: {$0.buttonIndex == cardIndex}) {
//                return card
//            } else {
//                return nil
//            }
//        } else {assert(false)}
//    }
    
//    private func removeSelectedCardsFromTable() {
//        for card in game.selectedCards {
//            if let index = game.cardsOnTheTable.firstIndex(of: card) {
//                game.cardsOnTheTable.remove(at: index)
//            } else {assert(false)}
//        }
//    }
//
//    private func removeCardFromSelected(_ card: Card) {
//        if let index = game.selectedCards.firstIndex(of: card) {
//            game.selectedCards.remove(at: index)
//        }
//    }
//
//    private func addCardsOnTableFromDeck() {
//        for card in game.selectedCards {
//            let newCard = game.deckOfCards.removeLast()
//            newCard.buttonIndex = card.buttonIndex
//            game.cardsOnTheTable.append(newCard)
//        }
//    }
    
//    @IBAction private func touchCard(_ sender: UIButton) {
//        if let card = cardByButton(sender) {
//            if game.selectedCards.count == 3 {
//                if game.successfulMatch {
//                    game.scoreCounter += 3
//                    removeSelectedCardsFromTable()
//                    if !game.deckOfCards.isEmpty {
//                        addCardsOnTableFromDeck()
//                    }
//                    let touchedCardIsSelected = game.selectedCards.contains(card)
//                    game.selectedCards.removeAll()
//                    if !touchedCardIsSelected {
//                        game.selectedCards.append(card)
//                    }
//                } else {
//                    game.scoreCounter -= 5
//                    game.selectedCards.removeAll()
//                    game.selectedCards.append(card)
//                }
//            } else {
//                if game.selectedCards.contains(card) {
//                    game.scoreCounter -= 1
//                    removeCardFromSelected(card)
//                } else {
//                    game.selectedCards.append(card)
//                }
//            }
//            updateViewFromModel()
//        } else {print("Touched card is not on the table.")}
//    }
    
    @IBOutlet private weak var dealCardsButton: UIButton!
    
    @IBAction private func DealThreeMoreCards(_ sender: UIButton) {
//        if !dealCardsButtonIsDisabled {
//            if game.selectedCards.count == 3 && game.successfulMatch {
//                game.scoreCounter += 3
//                removeSelectedCardsFromTable()
//                addCardsOnTableFromDeck()
//                game.selectedCards.removeAll()
//            } else {
//                for _ in 1...3 {
//                    let newCard = game.deckOfCards.removeLast()
//                    newCard.buttonIndex = game.buttonIndices.removeFirst()
//                    game.cardsOnTheTable.append(newCard)
//                }
//            }
//            updateViewFromModel()
//        } else {assert(false, "dealCardsButton should be disabled")}
    }
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func startNewGame(_ sender: UIButton) {
//        game = SetGame()
//        updateViewFromModel()
    }
    
    private func updateScoreLabel() {
//        let attributesForScoreCountLabel: [NSAttributedString.Key : Any] = [
//            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        ]
//        let attributedStringForScoreLabel = NSAttributedString(string: "Score: \(game.scoreCounter)", attributes: attributesForScoreCountLabel)
//        scoreLabel.attributedText = attributedStringForScoreLabel
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
//    private func changeCardAspectRatio() {
//        for card in cardButtons {
//            let cardAspectRatioConstraint = NSLayoutConstraint(
//                item: card,
//                attribute: .width,
//                relatedBy: .equal,
//                toItem: card,
//                attribute: .height,
//                multiplier: 8 / 17,
//                constant: 0)
//            card.addConstraint(cardAspectRatioConstraint)
//        }
//    }
    
//    private func colorFromEnum(color: ColorOfCard) -> UIColor {
//        switch color {
//        case .green: return #colorLiteral(red: 0, green: 0.6498066187, blue: 0.2595749497, alpha: 1)
//        case .purple: return #colorLiteral(red: 0.6721233726, green: 0.1548318267, blue: 0.6646618247, alpha: 1)
//        case .red: return #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
//        }
//    }
//
//    private func symbolFromEnum(symbol: SymbolOfCard) -> String {
//        switch symbol {
//        case .triangle: return "\u{25B2}"
//        case .circle: return "\u{25CF}"
//        case .square: return "\u{25A0}"
//        }
//    }
//
//    private func alphaFromEnum(shade: ShadeOfCard) -> CGFloat {
//        switch shade {
//        case .open: return 1.0
//        case .striped: return 0.25
//        case .solid: return 1.0
//        }
//    }
//
//    private func strokeWidthFromEnum(shade: ShadeOfCard) -> CGFloat {
//        switch shade {
//        case .open: return 5.0
//        case .striped: return 0.0
//        case .solid: return 0.0
//        }
//    }

//    private func titleForCard(_ card: Card) -> String {
//        let stringArray = Array(repeating: symbolFromEnum(symbol: card.symbol), count: card.numberOfItems)
//        return stringArray.joined(separator: "\n")
//    }
//
//    private func createAttributedString(for card: Card, withFontSize fontSize: CGFloat) -> NSAttributedString {
//        UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
//        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
//        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
//        let color = colorFromEnum(color: card.color)
//        let alpha = alphaFromEnum(shade: card.shade)
//        let colorWithAlpha = color.withAlphaComponent(alpha)
//        let strokeWidth = strokeWidthFromEnum(shade: card.shade)
//        return NSAttributedString(string: titleForCard(card), attributes: [.font : font, .foregroundColor : colorWithAlpha, .strokeWidth : strokeWidth])
//    }
//
//    private func wellSizedTitleString(for card: Card) -> NSAttributedString {
//        let verticalRowSpacing = CGFloat(cardButtons[0].bounds.size.height / 3.0)
//        let attemptedTitleString = createAttributedString(for: card, withFontSize: verticalRowSpacing)
//        let probablyOkayTitleStringFontSize = verticalRowSpacing / ((attemptedTitleString.size().height / CGFloat(card.numberOfItems)) / verticalRowSpacing)
//        let probablyOkayTitleString = createAttributedString(for: card, withFontSize: probablyOkayTitleStringFontSize)
//        if probablyOkayTitleString.size().width > cardButtons[0].bounds.size.width {
//            return createAttributedString(for: card, withFontSize: probablyOkayTitleStringFontSize / (probablyOkayTitleString.size().width / cardButtons[0].bounds.size.width))
//        } else {
//            return probablyOkayTitleString
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for button in cardButtons {
//            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//            button.layer.cornerRadius = 8.0
//        }
        
        dealCardsButton.layer.cornerRadius = 3.2
        newGameButton.layer.cornerRadius = 3.2
        
        dealCardsButton.titleLabel?.textAlignment = NSTextAlignment.center
        dealCardsButton.setTitle("Deal 3\nMore Cards", for: UIControl.State.normal)
        dealCardsButton.titleLabel?.numberOfLines = 2
        
//        updateViewFromModel()
    }
    
//    private func updateViewFromModel() {
//        for button in cardButtons {
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
//            button.setTitle("", for: UIControl.State.normal)
//            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//        }
//        for card in game.cardsOnTheTable {
//            cardButtons[card.buttonIndex].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0.6, alpha: 1)
//            let buttonTitleString = wellSizedTitleString(for: card)
//            cardButtons[card.buttonIndex].setAttributedTitle(buttonTitleString, for: UIControl.State.normal)
//            if game.selectedCards.contains(card) {
//                cardButtons[card.buttonIndex].layer.borderWidth = 3.0
//                cardButtons[card.buttonIndex].layer.borderColor = #colorLiteral(red: 0, green: 0.5446566343, blue: 0.9828409553, alpha: 1)
//            }
//        }
//        if game.selectedCards.count == 3 {
//            for card in game.selectedCards {
//                cardButtons[card.buttonIndex].layer.borderWidth = 3.0
//                if game.successfulMatch {
//                    cardButtons[card.buttonIndex].layer.borderColor = #colorLiteral(red: 0.1898198426, green: 0.9772902131, blue: 0, alpha: 1)
//                } else {
//                    cardButtons[card.buttonIndex].layer.borderColor = #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
//                }
//            }
//        }
//        if dealCardsButtonIsDisabled {
//            dealCardsButton.backgroundColor = #colorLiteral(red: 0.3272040486, green: 0.4194450378, blue: 0.8449910283, alpha: 1).withAlphaComponent(0.15)
//            dealCardsButton.isEnabled = false
//        } else {
//            dealCardsButton.backgroundColor = #colorLiteral(red: 0.3272040486, green: 0.4194450378, blue: 0.8449910283, alpha: 1)
//            dealCardsButton.isEnabled = true
//        }
//        updateScoreLabel()
//    }
}
