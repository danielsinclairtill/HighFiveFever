//  Model for Enemy bot
//  EnemyBot.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class EnemyBot: SKSpriteNode, Bot, HorizontalMover, Removable {
   
    var highFiveAction: SKAction?
    var moveAction: SKAction?
    
    required init(normalFilename: String, highFiveFilename: String) {
        
        let normalBotTexture = SKTexture(imageNamed: normalFilename)
        let highFiveTexture = SKTexture(imageNamed: highFiveFilename)
        
        self.highFiveAction = SKAction.animate(with: [highFiveTexture, normalBotTexture], timePerFrame: 0.1)
        
        // Call super method
        super.init(texture: normalBotTexture, color: UIColor.clear, size: (normalBotTexture.size()))
    }
   
    fileprivate func setMoveAction(action: SKAction) {
        self.moveAction = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
