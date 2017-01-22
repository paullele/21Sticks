//
//  GameMenu.swift
//  21Sticks
//
//  Created by apple on 21/11/2016.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class GameMenu: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTheGame" {
            if let vc = segue.destination as? GamePlay {
                vc.computerGoesFirst = true;
                vc.playersTurn = false;
            }
        }
        
    }
}
