//  Model for Player bot
//  PlayerBot.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-15.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerBot: SKSpriteNode {
    let highFiveAction: SKAction?
    let moveUpwardsAction: SKAction?
    let moveDownwardsAction: SKAction?
    
    required init(normalFilename: String, highFiveFilename: String, delta: CGPoint) {
        let normalTexture = SKTexture(imageNamed: normalFilename)
        let highFiveTexture = SKTexture(imageNamed: highFiveFilename)
        
        self.highFiveAction = SKAction.animate(with: [highFiveTexture, normalTexture], timePerFrame: 0.1)
        self.moveUpwardsAction = SKAction.moveBy(x: delta.x, y: delta.y, duration: 0)
        self.moveDownwardsAction = SKAction.moveBy(x: delta.x, y: -delta.y, duration: 0)
        
        super.init(texture: normalTexture, color: UIColor.clear, size: normalTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highFive() -> Void {
        self.run(self.highFiveAction!)
    }
    
    func moveUpwards() -> Void {
        self.run(moveUpwardsAction!)
    }
    
    func moveDownwards() -> Void {
        self.run(moveDownwardsAction!)
    }
}
