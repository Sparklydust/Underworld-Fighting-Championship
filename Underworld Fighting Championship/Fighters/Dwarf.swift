//
//  Dwarf.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


// Define the dwarf character
internal class Dwarf: Fighter {
    
    override init(fighterName: String) {
        
        super.init(fighterName: fighterName)
        lifePoints = 25
        
        self.weapon = Axe()
    }
}



