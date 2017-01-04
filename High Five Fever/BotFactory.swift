//
//  BotFactory.swift
//  High Five Fever
//  API for creating Bots
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import SpriteKit

class BotFactory {
    
    func createPlayerBotWith(_ normalFilename: String, and highFiveFilename: String, position: CGPoint, textureScaledBy: CGFloat, physicsBodyScaledBy scaleFactor: CGFloat) -> PlayerBot {
        
        let playerBot: PlayerBot = PlayerBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename)
        
        let movementDelta: CGPoint = CGPoint(x: 0, y: 70)
        playerBot.setMoveActionsBy(movementDelta)
        
        playerBot.position = position
        playerBot.setScale(textureScaledBy)
        
        initializePhysicsBodyOf(playerBot, isPlayer: true, categoryBitMask: .playerBot, contactBitMask: .enemyBot)
        
        
        return playerBot
    }
    
    func createEnemyBotWith(_ normalFilename: String, and highFiveFilename: String, position: CGPoint, textureScaledBy: CGFloat, physicsBodyScaledBy scaleFactor: CGFloat) -> EnemyBot {
        
        let enemyBot: EnemyBot = EnemyBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename)
        
        let movementDelta: CGPoint = CGPoint(x: 50, y: 0)
        enemyBot.setMoveActionBy(movementDelta, delayedBy: 0.3)
        
        enemyBot.position = position
        enemyBot.setScale(textureScaledBy)
        
        initializePhysicsBodyOf(enemyBot, isPlayer: false, categoryBitMask: .enemyBot, contactBitMask: .noContact)
        
        return enemyBot
    }
    
    
    private func initializePhysicsBodyOf(_ spriteNode: SKSpriteNode, isPlayer: Bool, categoryBitMask: ColliderType, contactBitMask: ColliderType) -> Void {
        
        let width = spriteNode.size.width / 4.5
        let height = spriteNode.size.height / 10.0
        let size = CGSize(width: width, height: height)
        
        var centerShift: CGPoint
        if isPlayer {
            centerShift = CGPoint(x: -28.5, y: 0.0)
        } else {
            centerShift = CGPoint(x: 20.0, y: 0.0)
        }
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: size, center: centerShift)
        
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.usesPreciseCollisionDetection = true
        spriteNode.physicsBody?.categoryBitMask = categoryBitMask.rawValue
        spriteNode.physicsBody?.contactTestBitMask = contactBitMask.rawValue
        spriteNode.physicsBody?.collisionBitMask = 0
        
    }
}
