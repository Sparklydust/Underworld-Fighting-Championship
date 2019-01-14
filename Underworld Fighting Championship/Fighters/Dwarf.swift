//
//  Dwarf.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 02/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation

// Define the Dwarf character
internal class Dwarf: Fighter {

  override init(fighterName: String) {
    super.init(fighterName: fighterName)
    lifePoints = 35
    self.weapon = Axe()
  }
}
