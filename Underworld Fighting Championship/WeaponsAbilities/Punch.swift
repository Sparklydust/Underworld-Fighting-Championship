//
//  Punch.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 04/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation

// The weapon to be used by the Colossus
internal class Punch: Weapon {

  init() {
    super.init(hitScore: 5)
  }
}

// The special weapon used when the random chest pops up
internal class SpecialPunch: Weapon {

  init() {
    super.init(hitScore: 25)
  }
}
