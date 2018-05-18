//  Factory for creating game scene
//  SceneFactory.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import SpriteKit

enum WallEdge {
    case right
    case left
}

class SceneFactory {
    
    func createBackground(filename: String, position: CGPoint, size: CGSize) -> SKSpriteNode {
        let background = SKSpriteNode(imageNamed: filename)
        background.position = position
        background.size = size
        background.zPosition = -1
        
        return background
    }
    
    func createScoreLabel(position: CGPoint) -> SKLabelNode {
        let scoreLabel = SKLabelNode()
        
        scoreLabel.position = position
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        
        return scoreLabel
    }
    
    func createWallOn(edge: WallEdge, of scene: GameScene) -> SKNode? {
        let wall = SKNode()
   
        let position: CGPoint?
        
        switch edge {
        case .left:
            position = CGPoint(x: 0, y: 0)
        case .right:
            position = CGPoint(x: scene.frame.width, y: 0)
        }

        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: scene.frame.height))
        wall.position = position!
        wall.physicsBody?.affectedByGravity = false
        wall.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        wall.physicsBody?.contactTestBitMask = ColliderType.enemyBot.rawValue
        wall.physicsBody?.collisionBitMask = 0
        
        return wall
    }
}
