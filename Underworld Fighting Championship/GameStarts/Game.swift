//
//  Game.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 18/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


internal class Game {
    
    // Player one and two created to play the game!
    let playerOne = Player()
    let playerTwo = Player()
    
    // Variables to be used for statistic
    var totalAttackMade = 0
    var attackPointsGiven = 0
    var lifePointsGiven = 0
    var lifePointsActionUsed = 0
    var playerTurnNumber = 0
    var luckyWeaponTrigger = 0
    var deadFighters = 0
    
    
    // A list with all the characters available in the begining of the game
    var listOfAllCharacters = [Warrior(fighterName: ""), Wizard(fighterName: ""), Colossus(fighterName: ""), Dwarf(fighterName: "")]
    
    
    fileprivate func startingMessage() {
        print("\nWelcome to the Underworld Fighting Championship. \n\nTo get started, choose three fighters within the list below using the number associated to it, and name them uniquely.")
    }
    
    
    func charactersPresentation() {
        print("""
            
            1. Warrior:   \(listOfAllCharacters[0].lifePoints) life points and a \(Sword().hitScore) hit damages.
            
            2. Wizard:    \(listOfAllCharacters[1].lifePoints) life points and a \(Sceptre().hitScore) life points back to any fighter in game.
            
            3. Colossus:  \(listOfAllCharacters[2].lifePoints) life points and a \(Punch().hitScore) hit damages.
            
            4. Dwarf:     \(listOfAllCharacters[3].lifePoints) life points and a \(Axe().hitScore) hit damages.
            
            """)
    }
    
    
    // Players make their team
    func preparePlayersTeam() {
        
        print("\n\n\n--- PLAYER ONE, YOUR TURN ---\n")
        // Player 1 make his team
        let playerOneFightersNameList = playerOne.makeTheTeam(listOfFightersName: [""])
        
        print("\n\n--- PLAYER TWO, YOUR TURN ---\n")
        // Player 2 make his team
        _ = playerTwo.makeTheTeam(listOfFightersName: playerOneFightersNameList)
        
        print("\n\n\n\n--- Player 1 and Player 2 teams are ready, time to get serious! --- \n\n!!! Prepare for the fight !!!\n\n")
    }
    
    
    // The master game actions loop on fighters, by fighters, for fighters
    fileprivate func playersLoop(playerTurn: Player, opponent: Player) {
        
        let playerTurn = playerTurn
        let opponent = opponent
        
        // Lucky dice to randomly trigger a special chest on game if number 3 goes out
        let randomChestOnGame = Int(arc4random_uniform(6))
        
        // Player sees the list of his fighter
        print("\n\n--- Which one of your fighter you want to play with? ---\n")
        
        playerTurn.fightersDescription()
        
        // Switch to choose the action fighter
        let theStriker = playerTurn.fightersSwitch()
        print("\n\nYou have chosen \(theStriker) \(theStriker.fighterName) with a \(theStriker.weapon!.hitScore) attack points \(theStriker.weapon!).")
        
        // A chest appears randomly and the fighter get a new bad ass weapon
        if randomChestOnGame == 3 {
            theStriker.weapon?.bigWeapon()
            print("\n\n\n🍀 YOU ARE THE LUCKY ONE AND GOT TO OPEN A SPECIAL CHEST\n\nYour weapon has now a \(theStriker.weapon!.hitScore) attack points ⚔️")
            
            // Variable for game statistics
            luckyWeaponTrigger += 1
        }
        
        // If not the Wizard, the player choose a character to strike
        if theStriker.isHealer() == false {
            
            print("\n\n--- Which fighter you want to attack? ---")
            opponent.fightersDescription()
            
            // Switch that choose a fighter to attack
            let theVictim = opponent.fightersSwitch()
            
            // Attack on the victim trigger
            theStriker.actionOn(fighter: theVictim)
            
            // To make life points stick to zero instead of going negative
            if theVictim.lifePoints <= 0 {
                theVictim.lifePoints = 0
            }
            
            // To make life points stick to zero after an attack instead of going negative
            if (theVictim.lifePoints - theStriker.weapon!.hitScore) >= 0 {
                print("\n\(theVictim) \(theVictim.fighterName) has been attacked. \(theVictim.lifePoints - theStriker.weapon!.hitScore) life points is now remaining.")
            }
            else {
                print("\n\(theVictim) \(theVictim.fighterName) has been attacked. 0 life points is now remaining.")
            }
            
            // Variables for game statistics
            attackPointsGiven += theStriker.weapon!.hitScore
            totalAttackMade += 1
            
            if theVictim.lifePoints <= 0 {
                print("\n!!! \(theVictim.fighterName.uppercased()) IS NOW DEAD 😵 !!!")
                
                // Variable for game statistics
                deadFighters += 1
            }
        }
        // If the Wizard was chosen, the player choose one of his fighter to give life points back
        else if theStriker.isHealer() == true {
            
            print("\n\n--- Which one of your fighter you want to give life points back to? ---")
            playerTurn.fightersDescription()
            
            // Switch that choose the person to save
            let theSick = playerTurn.fightersSwitch()
            
            // Returning life points trigger
            theStriker.actionOn(fighter: theSick)
            print("\n\n\(theSick) \(theSick.fighterName) feels a bit better. \(theSick.lifePoints - theStriker.weapon!.hitScore) life points is now remaining.")
            
            // Variables for game statistics
            lifePointsGiven += theStriker.weapon!.hitScore
            lifePointsActionUsed += 1
        }
    }
    
    
    // The main game loop that keeps looping until all the fighters of a players are dead
    fileprivate func gameLoop() -> Player {
        
        var isPlayerOneTurn = true
        
        while playerOne.haveFightersAlive() && playerTwo.haveFightersAlive() {
            
            if isPlayerOneTurn {
                
                print("\n\n--- PLAYER ONE, YOUR TURN ! ---")
                playersLoop(playerTurn: playerOne, opponent: playerTwo)
            }
            else {
                
                print("\n\n--- PLAYER TWO, YOUR TURN ! ---")
                playersLoop(playerTurn: playerTwo, opponent: playerOne)
            }
            
            isPlayerOneTurn = !isPlayerOneTurn
            // Variable for statistics
            playerTurnNumber += 1
        }
        
        // Check which player is the winner
        if playerOne.haveFightersAlive() == true {
            return playerOne
        }
        else {
            return playerTwo
        }
    }
    
    
    // At this point, the game Begins 🎮
    func start() {
        
        startingMessage()
        // Each player choose their fighters one after the other
        preparePlayersTeam()
        _ = gameLoop()
        victoryMessage()
        printStatistics()
        
        print("GAME OVER\n\n\n")
    }
    
    
    fileprivate func victoryMessage() {
        
        if playerOne.haveFightersAlive() == true {
            print("\n\n\n--- 👑 CONGRATLATIONS PLAYER ONE! YOU WIN ! 👑 ---\n\n")
        }
        else {
            print("\n\n\n--- 👑 CONGRATULATIONS PLAYER TWO! YOU WIN ! 👑 ---\n\n")
        }
    }
    
    
    // This is where the game statistics are grouped
    fileprivate func printStatistics() {
        
        var player1TotalTurn = 0
        var player2TotalTurn = 0
        
        
        // Calculate the time each player has play a turn
        if playerOne.haveFightersAlive() == true {
            player1TotalTurn = playerTurnNumber / 2 + 1
        }
        else {
            player1TotalTurn = playerTurnNumber / 2
        }
        
        if playerTwo.haveFightersAlive() == true {
            player2TotalTurn = playerTurnNumber / 2 + 1
        }
        else {
            player2TotalTurn = playerTurnNumber / 2
        }
        
        print("""
            
            -- Game General Statistics --
            
            - Player One Total Turn:   \(player1TotalTurn)
            - Player Two Total Turn:   \(player2TotalTurn)
            - Total Attacks:           \(totalAttackMade)
            - Total Attack Points:     \(attackPointsGiven)
            - Total Wizard' s Action:  \(lifePointsActionUsed)
            - Total Life Points Back:  \(lifePointsGiven)
            - Lucky Weapon Triggered:  \(luckyWeaponTrigger)
            - Fighters Dead in Game:   \(deadFighters)
            
            
            
            """)
    }
}

