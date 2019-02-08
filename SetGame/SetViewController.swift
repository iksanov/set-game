//
//  ViewController.swift
//  SetGame
//
//  Created by MacBookPro on 28/11/2018.
//  Copyright © 2018 Iksanov. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {    
    @IBOutlet weak var playgroundView: PlaygroundView! {
        didSet {
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(shuffleCards(recognizer:)))
            playgroundView.addGestureRecognizer(rotate)
        }
    }

    private var game = SetGame()
    
    @objc func shuffleCards(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
            case .ended:
                game.reshuffle()
                updateViewFromModel()
            default: break
        }
        
    }
    
    @objc private func touchCardBy(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            guard let tappedView = recognizer.view else { assert(false) }
            guard let indexOftouchedCard = playgroundView.subviews.firstIndex(of: tappedView) else { return }  // TODO: crash if assert(false) instead of return
            let touchedCard = game.cardsOnTheTable[indexOftouchedCard]
            game.cardWasTouched(touchedCard)
            updateViewFromModel()
        default:
            break
        }
    }
    
    private func updateViewFromModel() {
        playgroundView.numberOfCardsOnTheTable = game.cardsOnTheTable.count
        
        while !playgroundView.subviews.isEmpty {
            playgroundView.subviews.first?.removeFromSuperview()
        }
        
        for card in game.cardsOnTheTable {
            let newCardView = SetCardView(color: card.color, symbol: card.symbol, shade: card.shade, numberOfItems: card.numberOfItems)
            
            if game.selectedCards.contains(card) {
                newCardView.selected = true
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(touchCardBy(recognizer:)))
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
                    viewOfSelectedCard.unsuccessful = true
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
    
    @IBOutlet private weak var dealCardsButton: UIButton!
    
    @IBAction func dealThreeMoreCards(_ sender: Any) {
        if !dealCardsButtonIsDisabled {
            game.addThreeCards()
            updateViewFromModel()
        }
    }
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func updateScoreLabel() {
        let attributesForScoreCountLabel: [NSAttributedString.Key : Any] = [
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedStringForScoreLabel = NSAttributedString(string: "Score: \(game.scoreCounter)", attributes: attributesForScoreCountLabel)
        scoreLabel.attributedText = attributedStringForScoreLabel
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dealCardsButton.layer.cornerRadius = 3.2
        newGameButton.layer.cornerRadius = 3.2
        
        dealCardsButton.titleLabel?.textAlignment = NSTextAlignment.center
        dealCardsButton.setTitle("Deal 3\nMore Cards", for: UIControl.State.normal)
        dealCardsButton.titleLabel?.numberOfLines = 2
        
        updateViewFromModel()
    }
}
