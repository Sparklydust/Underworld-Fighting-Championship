//
//  Player.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 09/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation

internal class Player {

  var listOfFighters = [Fighter]()

  // For the player to make his team and name each player chosen
  func makeTheTeam(listOfFightersName: [String]) -> [String] {

    var listOfFightersName = listOfFightersName

    // Present all fighters available
    gameAction.charactersPresentation()

    // Loop for players to select and name their fighters
    while listOfFighters.count < 3 {
      print("\nInput an associated number to select a fighter:")
      if let userChoice = readLine() {

        print("\nName your fighter:")
        if let nameChoice = readLine() {

          if listOfFightersName.contains(nameChoice) {
            print("\nName your fighter uniquely!")
          }
          else {
            listOfFightersName.append(nameChoice)

            switch userChoice {
            case "1":
              listOfFighters.append(Warrior(fighterName: "\(nameChoice.capitalized)"))
            case "2":
              listOfFighters.append(Wizard(fighterName: "\(nameChoice.capitalized)"))
            case "3":
              listOfFighters.append(Colossus(fighterName: "\(nameChoice.capitalized)"))
            case "4":
              listOfFighters.append(Dwarf(fighterName: "\(nameChoice.capitalized)"))
            default:
              print("\n!! You have not chosen three characters to enter the ring !! \n\n!! Enter a number associated to a fighter... !!\n")
            }
          }
        }
      }
    }
    showPlayerChoice()
    return listOfFightersName
  }

  // To show the player' s choice after he made it
  func showPlayerChoice() {

    print("\n\nYour chosen fighters are: \n")
    for fighter in listOfFighters {
      print("\(fighter) \(fighter.fighterName)")
    }
    print("")
  }

  // To describe player' s fighters names as well as their life points left and attack points
  func fightersDescription() {

    print("""
      
      1: \(listOfFighters[0])  \(listOfFighters[0].fighterName),  \(listOfFighters[0].lifePoints) life points,  \(listOfFighters[0].hittingScore()) attack points.
      2: \(listOfFighters[1])  \(listOfFighters[1].fighterName),  \(listOfFighters[1].lifePoints) life points,  \(listOfFighters[1].hittingScore()) attack points.
      3: \(listOfFighters[2])  \(listOfFighters[2].fighterName),  \(listOfFighters[2].lifePoints) life points.  \(listOfFighters[2].hittingScore()) attack points.
      
      """)
  }

  // To use when needed to choose between player' s fighters list during the fight loop
  func fightersSwitch() -> Fighter {

    var playerChosen: Fighter?

    while playerChosen == nil {
      if let userChoice = readLine() {

        switch userChoice {
        case "1":
          playerChosen = listOfFighters[0]
        case "2":
          playerChosen = listOfFighters[1]
        case "3":
          playerChosen = listOfFighters[2]
        default:
          print("\n!!! Enter a number associated to a fighter to continue !!!\n")
        }

        if let player = playerChosen, player.lifePoints <= 0 {
          print("\n\n☠️ A DEAD FIGHTER IS A DEAD MAN ☠️\n\nChoose one still alive to continue...")
          playerChosen = nil
        }
      }
    }
    return playerChosen!
  }

  // Boolean that checks if a fighter is still alive
  func haveFightersAlive() -> Bool {
    for fighter in listOfFighters {

      if fighter.lifePoints > 0 {
        return true
      }
    }
    return false
  }
}
