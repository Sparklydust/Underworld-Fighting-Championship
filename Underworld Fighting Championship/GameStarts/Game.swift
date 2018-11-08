//
//  Game.swift
//  Underworld Fighting Championship
//
//  Created by Roland Lariotte on 18/10/2018.
//  Copyright © 2018 Roland Lariotte. All rights reserved.
//

import Foundation


internal class Game {
    
    // Player One and Player Two created to play the game!
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
    
    
    fileprivate func startingMessage() {
        print("\nWelcome to the Underworld Fighting Championship. \n\nTo get started, choose three fighters within the list below using the number associated to it, and name them uniquely.")
    }
    
    
    // A list with all characters available at the begining of the game
    func charactersPresentation() {
        print("""
            
            1. Warrior:   \(Warrior(fighterName: "").lifePoints) life points and a \(Sword().hitScore) hit damages.
            
            2. Wizard:    \(Wizard(fighterName: "").lifePoints) life points and a \(Sceptre().hitScore) life points back to any fighter in game.
            
            3. Colossus:  \(Colossus(fighterName: "").lifePoints) life points and a \(Punch().hitScore) hit damages.
            
            4. Dwarf:     \(Dwarf(fighterName: "").lifePoints) life points and a \(Axe().hitScore) hit damages.
            
            """)
    }
    
    
    // Players make their team
    func preparePlayersTeam() {
        
        print("\n\n\n--- PLAYER ONE, YOUR TURN ---\n")
        // Player 1 makes his team
        let playerOneFightersNameList = playerOne.makeTheTeam(listOfFightersName: [""])
        
        print("\n\n--- PLAYER TWO, YOUR TURN ---\n")
        // Player 2 makes his team
        _ = playerTwo.makeTheTeam(listOfFightersName: playerOneFightersNameList)
        
        print("\n\n\n\n--- Player 1 and Player 2 teams are ready, time to get serious! --- \n\n!!! Prepare for the fight !!!\n\n")
    }
    
    
    // A chest appears randomly inside the playersLoop() and the fighter get a new bad ass weapon
    fileprivate func randomizeLuckyChestFor(theStriker: Fighter) {
        
        // Lucky dice triggers a special chest on game if number 3 goes out
        let randomChestOnGame = Int(arc4random_uniform(6))
        
        if randomChestOnGame == 3 {
            
            if theStriker is Warrior {
                theStriker.weapon = SpecialSword()
            }
            else if theStriker is Wizard {
                theStriker.weapon = SpecialSceptre()
            }
            else if theStriker is Colossus {
                theStriker.weapon = SpecialPunch()
            }
            else {
                theStriker.weapon = SpecialAxe()
            }
            print("\n\n\n🍀 YOU ARE THE LUCKY ONE AND GOT TO OPEN A SPECIAL CHEST\n\nYour weapon has now a \(theStriker.weapon!.hitScore) attack points ⚔️")
            
            // Variable for game statistics
            luckyWeaponTrigger += 1
        }
    }
    
    
    // Method used in playerLoop() if the Wizard is selected to heal one of its allies
    fileprivate func healAction(with theStriker: Fighter, on allie: Fighter) {
        
        // Giving life points trigger
        theStriker.actionOn(fighter: allie)
        print("\n\n\(allie) \(allie.fighterName) feels a bit better. \(allie.lifePoints) life points is now remaining.")
        
        // Variables for game statistics
        lifePointsGiven += theStriker.weapon!.hitScore
        lifePointsActionUsed += 1
    }
    
    
    // Method used in playerLoop() for the fighter to attack its ennemie
    fileprivate func attackAction(with theStriker: Fighter, on ennemie: Fighter) {
        
        // Attack on the ennemie trigger
        theStriker.actionOn(fighter: ennemie)
        
        // Life points stick to zero after an attack instead of going negative
        if ennemie.lifePoints > 0 {
            print("\n\(ennemie) \(ennemie.fighterName) has been attacked. \(ennemie.lifePoints) life points is now remaining.")
        }
        else {
            ennemie.lifePoints = 0
            print("\n\(ennemie) \(ennemie.fighterName) has 0 life point remaining.")
        }
        
        // Variables for game statistics
        attackPointsGiven += theStriker.weapon!.hitScore
        totalAttackMade += 1
        
        if ennemie.lifePoints <= 0 {
            print("\n!!! \(ennemie.fighterName.uppercased()) IS NOW DEAD 😵 !!!")
            
            // Variable for game statistics
            deadFighters += 1
        }
    }
    
    
    // The master game actions loop on fighters, by fighters, for fighters
    fileprivate func playersLoop(playerTurn: Player, opponent: Player) {
        
        print("\n\n--- Which one of your fighters you want to play with? ---\n")
        
        // Player sees the list of his fighters
        playerTurn.fightersDescription()
        
        // Switch to choose the action fighter
        let theStriker = playerTurn.fightersSwitch()
        print("\n\nYou have chosen \(theStriker) \(theStriker.fighterName) with a \(theStriker.weapon!.hitScore) attack points \(theStriker.weapon!).")
        
        // When the lucky dice is thrown in game to randomly get a stronger weapon
        randomizeLuckyChestFor(theStriker: theStriker)
        
        // If the Wizard was chosen, the player chooses one of his fighters to give life points back to
        if theStriker.isHealer() {
            
            print("\n\n--- Which one of your fighters you want to give life points back to? ---")
            playerTurn.fightersDescription()
            
            healAction(with: theStriker, on: playerTurn.fightersSwitch())
        }
            // If not the Wizard, the player chooses a character to strike
        else {
            
            print("\n\n--- Which one of your ennemies you want to attack? ---")
            opponent.fightersDescription()
            
            attackAction(with: theStriker, on: opponent.fightersSwitch())
        }
    }
    
    
    // The main game loop that keeps looping until all the fighters of a players are dead
    fileprivate func gameLoop() {
        
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
    }
    
    
    // At this point, the game Begins 🎮
    func start() {
        
        startingMessage()
        // Each player chooses their fighters one after the other
        preparePlayersTeam()
        gameLoop()
        victoryMessage()
        printStatistics()
        
        print("GAME OVER\n\n\n")
    }
    
    
    fileprivate func victoryMessage() {
        
        if playerOne.haveFightersAlive() {
            print("\n\n\n--- 👑 CONGRATULATIONS PLAYER ONE! YOU WIN ! 👑 ---\n\n")
        }
        else {
            print("\n\n\n--- 👑 CONGRATULATIONS PLAYER TWO! YOU WIN ! 👑 ---\n\n")
        }
    }
    
    
    // This is where the game statistics are grouped to be displayed on screen
    fileprivate func printStatistics() {
        
        var player1TotalTurn = 0
        var player2TotalTurn = 0
        
        
        // Calculate the time each player has played a turn
        if playerOne.haveFightersAlive() {
            player1TotalTurn = playerTurnNumber / 2 + 1
        }
        else {
            player1TotalTurn = playerTurnNumber / 2
        }
        
        if playerTwo.haveFightersAlive() {
            player2TotalTurn = playerTurnNumber / 2 + 1
        }
        else {
            player2TotalTurn = playerTurnNumber / 2
        }
        
        print("""
            
            -- General Game Statistics --
            
            - Player One Total Turns:   \(player1TotalTurn)
            - Player Two Total Turns:   \(player2TotalTurn)
            - Total Attacks:            \(totalAttackMade)
            - Total Attack Points:      \(attackPointsGiven)
            - Total Wizard' s Actions:  \(lifePointsActionUsed)
            - Total Life Points Back:   \(lifePointsGiven)
            - Lucky Weapon Triggered:   \(luckyWeaponTrigger)
            - Fighters Dead in Game:    \(deadFighters)
            
            
            
            """)
    }

}

