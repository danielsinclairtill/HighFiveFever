//  Model for Player bot
//  PlayerBot.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class PlayerBot: SKSpriteNode, Bot, VerticalMover {
    var highFiveAction: SKAction?
    var moveUpwardsAction: SKAction?
    var moveDownwardsAction: SKAction?
    
    required init(normalFilename: String, highFiveFilename: String) {
        let normalTexture = SKTexture(imageNamed: normalFilename)
        let highFiveTexture = SKTexture(imageNamed: highFiveFilename)
        
        self.highFiveAction = SKAction.animate(with: [highFiveTexture, normalTexture], timePerFrame: 0.1)

        super.init(texture: normalTexture, color: UIColor.clear, size: normalTexture.size())
    }
    
    fileprivate func setUpwardAction(action: SKAction) {
        self.moveUpwardsAction = action
    }
    
    fileprivate func setDownwardAction(action: SKAction) {
        self.moveDownwardsAction = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

