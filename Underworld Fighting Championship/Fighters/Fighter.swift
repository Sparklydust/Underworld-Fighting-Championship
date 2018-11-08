//
//  main.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


// Define abilities available to all characters
internal class Fighter {
    
    // Properties of a fighter
    var fighterName: String
    var lifePoints: Int
    
    // Instance of the class Weapon
    var weapon: Weapon?
    
    init(fighterName: String) {
        
        lifePoints = 0
        self.fighterName = fighterName
    }
    
    
    // Method that defines strike score after a player hits another one
    func hittingScore() -> Int {
        
        if let fighterWeapon = weapon {
            return fighterWeapon.hitScore
        }
        else {
            return 0
        }
    }
    
    
    // Action to take life points after an attack
    func actionOn(fighter: Fighter) {
        
        if isHealer() == false {
            
            fighter.lifePoints -= hittingScore()
            print("\nYou took \(hittingScore()) life points to your ennemy.\n")
        }
        else if isHealer() == true {
            fighter.lifePoints += hittingScore()
            print("\nYou gave \(hittingScore()) life points back to your fella. ")
        }
    }
    
    
    // To determine the fighters that are not capable of healing their fellas
    func isHealer() -> Bool {
        
        _ = Warrior(fighterName: "")
        _ = Colossus(fighterName: "")
        _ = Dwarf(fighterName: "")
        
        return false
    }
    
}


