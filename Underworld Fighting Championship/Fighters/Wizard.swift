//
//  Wizard.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


// Define the Wizard character
internal class  Wizard: Fighter {
    
    override init(fighterName: String) {
        
        super.init(fighterName: fighterName)
        lifePoints = 50
        
        self.weapon = Sceptre()
    }
    
    
    // To determine that Wizard is the life points saver
    override func isHealer() -> Bool {
        
        _ = Wizard(fighterName: "")
        
        return true
    }

}


