//
//  SticksEngine.swift
//  21Sticks
//
//  Created by apple on 20/11/2016.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation


class SticksEngine {
    
    private var numberOfSticks = 21
    
    func withdrawSticks(_ number: Int) {
        numberOfSticks -= number
    }
    
    func computerDecisionSmart(_ number: Int) -> Int {
        
        if ((number - 2) % 3 == 0 || number - 2 == 0 || gameStatus == 1) {
            return 1
        } else {
            return 2
        }
    }
    
    func computerDecisionRandom() -> Int {
        
        let random = Int(arc4random_uniform(2)) % 2 + 1
        
        return random
        
    }
    
    var gameStatus: Int {
        get {
            return numberOfSticks
        }
    }
    
}
