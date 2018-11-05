//
//  Warrior.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


// Define the warrior character

internal class Warrior: Fighter {
    
    
    override init(fighterName: String) {
        
        super.init(fighterName: fighterName)
        lifePoints = 60
        
        self.weapon = Sword()
    }
}
