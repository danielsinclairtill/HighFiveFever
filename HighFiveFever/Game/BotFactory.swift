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
    
    func createPlayerBotWith(normalFilename: String, highFiveFilename: String, textureScaledBy: CGFloat, delta: CGPoint) -> PlayerBot {
        let playerBot: PlayerBot = PlayerBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename, delta: delta)
        initializePhysicsBody(spriteNode: playerBot, categoryBitMask: ColliderType.playerBot, contactBitMask: ColliderType.enemyBot)
        playerBot.setScale(textureScaledBy)
        return playerBot
    }
    
    func createEnemyBotWith(normalFilename: String, highFiveFilename: String, textureScaledBy: CGFloat, delta: CGPoint) -> EnemyBot {
        let enemyBot: EnemyBot = EnemyBot(normalFilename: normalFilename, highFiveFilename: highFiveFilename, delta: delta)
        initializePhysicsBody(spriteNode: enemyBot, categoryBitMask: ColliderType.enemyBot, contactBitMask: ColliderType.playerBot)
        enemyBot.setScale(textureScaledBy)
        return enemyBot
    }
    
    private func initializePhysicsBody(spriteNode: SKSpriteNode, categoryBitMask: ColliderType, contactBitMask: ColliderType) -> Void {
        guard let texture = spriteNode.texture else { return }
        
        spriteNode.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.usesPreciseCollisionDetection = true
        spriteNode.physicsBody?.categoryBitMask = categoryBitMask.rawValue
        spriteNode.physicsBody?.contactTestBitMask = contactBitMask.rawValue
        spriteNode.physicsBody?.collisionBitMask = 0
        
    }
}
