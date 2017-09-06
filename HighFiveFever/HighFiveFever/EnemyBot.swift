//  Model for Enemy bot
//  EnemyBot.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBot: SKSpriteNode {
    // Actions to perform
    let highFiveAction: SKAction?
    let moveBotAction: SKAction?
    
    required init(normalFilename: String, highFiveFilename: String, delta: CGPoint) {
        let normalBotTexture = SKTexture(imageNamed: normalFilename)
        let highFiveTexture = SKTexture(imageNamed: highFiveFilename)
        
        self.highFiveAction = SKAction.animate(with: [highFiveTexture, normalBotTexture], timePerFrame: 0.1)
        self.moveBotAction = SKAction.moveBy(x: delta.x, y: delta.y, duration: 0)
        
        // Call super method
        super.init(texture: normalBotTexture, color: UIColor.clear, size: (normalBotTexture.size()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highFive() -> Void {
        self.run(self.highFiveAction!)
    }
    
    func moveBot() {
        self.run(self.moveBotAction!)
    }
}
