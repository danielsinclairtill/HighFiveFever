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

enum ColliderType: UInt32 {
    case playerBot = 1;
    case enemyBot = 2;
    case wall = 4;
}

class BotFactory {
    
    func createPlayerBotWith(normalFilename: String, highFiveFilename: String, position: CGPoint, textureScaledBy: CGFloat, physicsBodyScaledBy: CGFloat) -> PlayerBot {
        let movement: CGPoint = CGPoint(x: 0, y: 70)
        let playerBot: PlayerBot = PlayerBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename, delta: movement)
        
        playerBot.position = position
        playerBot.setScale(textureScaledBy)
        initializePhysicsBody(spriteNode: playerBot, physicsBodyScaledBy: physicsBodyScaledBy, categoryBitMask: ColliderType.playerBot, contactBitMask: ColliderType.enemyBot)
        
        
        return playerBot
    }
    
    func createEnemyBotWith(normalFilename: String, highFiveFilename: String, position: CGPoint, textureScaledBy: CGFloat, physicsBodyScaledBy: CGFloat) -> EnemyBot {
        let movement: CGPoint = CGPoint(x: 50, y: 0)
        let enemyBot: EnemyBot = EnemyBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename, delta: movement)
        
        enemyBot.position = position
        enemyBot.setScale(textureScaledBy)
        initializePhysicsBody(spriteNode: enemyBot, physicsBodyScaledBy: physicsBodyScaledBy, categoryBitMask: ColliderType.enemyBot, contactBitMask: ColliderType.playerBot)
        
        return enemyBot
    }
    
    private func calculateScaledSize(spriteNode: SKSpriteNode, scaledBy: CGFloat) -> CGSize {
        let scaledWidth: CGFloat = spriteNode.size.width * scaledBy
        let scaledHeight: CGFloat = spriteNode.size.height * scaledBy
        
        return CGSize(width: scaledWidth, height: scaledHeight)
    }
    
    private func initializePhysicsBody(spriteNode: SKSpriteNode, physicsBodyScaledBy: CGFloat, categoryBitMask: ColliderType, contactBitMask: ColliderType) -> Void {
        let scaledSize: CGSize = calculateScaledSize(spriteNode: spriteNode, scaledBy: physicsBodyScaledBy)
        
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.usesPreciseCollisionDetection = true
        spriteNode.physicsBody?.categoryBitMask = categoryBitMask.rawValue
        spriteNode.physicsBody?.contactTestBitMask = contactBitMask.rawValue
        spriteNode.physicsBody?.collisionBitMask = 0
        
    }
}
