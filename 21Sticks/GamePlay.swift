//
//  ViewController.swift
//  21Sticks
//
//  Created by apple on 20/11/2016.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class GamePlay: UIViewController{
    
    @IBOutlet weak var sticksLeft: UILabel!
    
    @IBOutlet weak var displayMessage: UITextView!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    private var game = SticksEngine()
    var computerGoesFirst = false
    var playersTurn = true;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managePlayersButtons()
        
        if computerGoesFirst {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.computerTakesSticks()
            })
        }
    }
    
    func managePlayersButtons() {
        
        if playersTurn {
            button1.isEnabled = true
            button2.isEnabled = true
        } else {
            button1.isEnabled = false
            button2.isEnabled = false
            
        }
    
    }
    
    
    @IBAction func takeSticks(_ sender: UIButton) {
        
        let takenNumber = Int(sender.currentTitle!)
        
        game.withdrawSticks(takenNumber!)
        displaySticksLeft = game.gameStatus
        
        if takenNumber == 1 {
            displayMessage.text = "Player takes 1 stick"
        } else {
            displayMessage.text = "Player takes 2 sticks"
        }
        
        if displaySticksLeft <= 0 {
            displayMessage.text = "Computer wins"
            newGameButton.isSelected = true
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.computerTakesSticks()
            })
        }
        
        playersTurn = false
        managePlayersButtons()
        
    }
    
    
    @IBAction func onNewGame(_ sender: UIButton) {
        
        if displaySticksLeft == 0 {
            performSegue(withIdentifier: "NewGame", sender: UIButton())
        } else {
            let alert = UIAlertController(title: "Are you sure you want to start a new game?", message: nil, preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: {
                action in self.performSegue(withIdentifier: "NewGame", sender: nil)
            })
            
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            if let ppc = popoverPresentationController {
                ppc.sourceView = sender
                ppc.sourceRect = sender.bounds
            }
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func computerTakesSticks() {

        game.withdrawSticks(game.computerDecisionSmart(displaySticksLeft))
        
        if game.computerDecisionSmart(displaySticksLeft) == 1 {
            displayMessage.text = "Computer takes 1 stick"
        } else {
            displayMessage.text = "Computer takes 2 sticks"
        }
        
        displaySticksLeft = game.gameStatus
        
        if displaySticksLeft <= 0 {
            displayMessage.text = "Player wins"
            newGameButton.isSelected = true
            playersTurn = false
            managePlayersButtons()
        }
        
        playersTurn = true
        managePlayersButtons()
        
    }

    
    var displaySticksLeft: Int {
        get {
            return Int(sticksLeft.text!)!
        }
        set {
            sticksLeft.text = String(game.gameStatus)
        }
    }

}

