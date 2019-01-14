//
//  Swords.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation

// The weapon to be used by the Warrior
internal class Sword: Weapon {

  init() {
    super.init(hitScore: 10)
  }
}

// The special weapon used when the random chest pops up
internal class SpecialSword: Weapon {

  init() {
    super.init(hitScore: 30)
  }
}
