//  Factory for creating game scene
//  SceneFactory.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import SpriteKit

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
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        
        return scoreLabel
    }
}
