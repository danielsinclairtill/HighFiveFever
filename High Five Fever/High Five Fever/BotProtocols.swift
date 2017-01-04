//
//  BotProtocols.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2017-01-03.
//  Copyright © 2017 Lunet Apps. All rights reserved.
//

import SpriteKit

protocol Bot: class {
    
    var highFiveAction: SKAction? { get }
    
    init(normalFilename: String, highFiveFilename: String)
    
    func highFive() -> Void
    
}

extension Bot where Self: SKSpriteNode {
    
    func highFive() {
        self.run(highFiveAction!)
    }
}

protocol VerticalMover: class {
    
    var moveUpwardsAction: SKAction? { get set }
    var moveDownwardsAction: SKAction? { get set }
    
    func setMoveActionsBy(_ delta: CGPoint) -> Void
    func moveUpwards() -> Void
    func moveDownwards() -> Void
    
}

extension VerticalMover where Self: SKSpriteNode {
    
    func setMoveActionsBy(_ delta: CGPoint) {
        self.moveUpwardsAction = SKAction.moveBy(x: delta.x, y: delta.y, duration: 0)
        self.moveDownwardsAction = SKAction.moveBy(x: delta.x, y: -delta.y, duration: 0)
    }
    
    func moveUpwards() {
        self.run(moveUpwardsAction!)
    }
    
    func moveDownwards() {
        self.run(moveDownwardsAction!)
    }
}

protocol HorizontalMover: class {
    
    var moveAction: SKAction? { get set }
    
    func setMoveActionBy(_ delta: CGPoint, delayedBy delay: TimeInterval) -> Void
    func move() -> Void
}

extension HorizontalMover where Self: SKSpriteNode {
    
    func setMoveActionBy(_ delta: CGPoint, delayedBy delay: TimeInterval) {
        let moveForward = SKAction.moveBy(x: delta.x, y: delta.y, duration: 0)
        let moveDelay = SKAction.wait(forDuration: delay)
        let sequence = SKAction.sequence([moveForward, moveDelay])
        self.moveAction = SKAction.repeatForever(sequence)
    }
    
    func move() {
        self.run(moveAction!)
    }
}

protocol Removable {
    func die() -> Void
}

extension Removable where Self: SKSpriteNode {
    
    func die() {
        let delay = SKAction.wait(forDuration: 0.3)
        let sequence = SKAction.sequence([delay, SKAction.removeFromParent()])
        self.run(sequence)
    }
}
