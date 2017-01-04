//
//  GameScene.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-09.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

// TODO: - SKNodes for each scene component
// TODO: - Get rid of timers
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playerBotNormalFilename: String?
    var playerBotHighFiveFilename: String?
    var enemyBotNormalFilename: String?
    var enemyBotHighFiveFilename: String?
    
    weak var playViewController: PlayViewController!
    
    // Factories
    let botFactory: BotFactory = BotFactory()
    let sceneFactory: SceneFactory = SceneFactory()
    
    // Scene Components
    let nonMovableNodes = SKNode()
    let playerContainer = SKNode()
    let enemyBots = SKNode()
    var scoreLabel = SKLabelNode()
    var player: PlayerBot?
    
    // Counter variables
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var botCount = 0
    
    // Global Variables
    var playerPosition = [0,1,0,0]
    var currentPositionIndex = 1;
    
    var enemyBotCreationTimer: Timer?
    
    /* Scene starting point */
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        
        initiateScene();
        
        // Create enemy bots
        enemyBotCreationTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(addEnemyBot), userInfo: nil, repeats: true);
    }
    
    /* Contact between objects occurred */
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        // Game over
        if bodyA.categoryBitMask == ColliderType.wall.rawValue || bodyB.categoryBitMask == ColliderType.wall.rawValue {
            endGame()
        }
        
        // Score
        if bodyA.categoryBitMask == ColliderType.playerBot.rawValue && bodyB.categoryBitMask == ColliderType.enemyBot.rawValue {
            scoreAndRemove(enemyBot: bodyB)
        }
        
    }

    /* Utility function to create scene with initial components */
    private func initiateScene() {
        // Set up Swipe gesture recognizer
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(movePlayerUp))
        swipeUp.direction = .up
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(movePlayerDown))
        swipeDown.direction = .down
        
        self.view?.addGestureRecognizer(swipeUp)
        self.view?.addGestureRecognizer(swipeDown)
        
        self.addChild(nonMovableNodes)
        // Add background to scene
        let backgroundSize = CGSize(width: Constants.backgroundWidth, height: Constants.backgroundHeight)
        let background = sceneFactory.createBackground(filename: Constants.backgroundFilename, position: setToScreenCenter(self), size: backgroundSize)
        nonMovableNodes.addChild(background);
        
        // Set score label
        scoreLabel = sceneFactory.createScoreLabel(position: CGPoint(x: Constants.scoreLabelX, y: Constants.scoreLabelY))
        nonMovableNodes.addChild(scoreLabel);
        
        // Set up wall
        let wall: SKNode = sceneFactory.createWallOn(edge: WallEdge.right, of: self)!
        nonMovableNodes.addChild(wall)
        
        var normalFilename: String
        var highFiveFilename: String
        // Add player bot to scene
        if let normal = playerBotNormalFilename, let highFive = playerBotHighFiveFilename {
            normalFilename = normal
            highFiveFilename = highFive
        } else { // Default
            normalFilename = Constants.playerNormalFilename
            highFiveFilename = Constants.playerHighFiveFilename
        }
        
        player = botFactory.createPlayerBotWith(normalFilename, and: highFiveFilename, position: CGPoint(x: 650, y: 200), textureScaledBy: 0.45, physicsBodyScaledBy: 0.3)
        player?.zPosition = Constants.zPositionValues[1]
        self.addChild(playerContainer)
        playerContainer.addChild(player!)
        
        self.addChild(enemyBots)
    }
    
    /* Helper function to return coordinates of screens center */
    private func setToScreenCenter(_ screen: GameScene) -> CGPoint {
        return CGPoint(x: screen.frame.midX, y: screen.frame.midY);
    }
    
    /* Utility function to add enemy bots to scene and start their animation */
    func addEnemyBot() -> Void {
        botCount += 1
        let randomSource = GKRandomSource.sharedRandom()
        
        let positionIndex = randomSource.nextInt(upperBound: 4)
        
        var normalFilename: String
        var highFiveFilename: String
        if let normal = enemyBotNormalFilename, let highFive = enemyBotHighFiveFilename {
            normalFilename = normal
            highFiveFilename = highFive
        } else {
            normalFilename = Constants.defaultBotNormalFilename
            highFiveFilename = Constants.defaultBotHighFiveFilename
        }
        
        let bot = botFactory.createEnemyBotWith(normalFilename, and: highFiveFilename, position: Constants.botPosition[positionIndex], textureScaledBy: 0.45, physicsBodyScaledBy: 0.3)
        
        bot.name = "enemy bot \(botCount)"
        bot.zPosition = Constants.zPositionValues[positionIndex]
        enemyBots.addChild(bot);
        
        bot.move()
    }
    
    func movePlayerUp(){
        if (playerPosition.last! == 1) { // player is at last spot
            return;
        }
        
        player?.moveUpwards()
        playerPosition[currentPositionIndex] = 0;
        currentPositionIndex += 1;
        playerPosition[currentPositionIndex] = 1;
        player?.zPosition = Constants.zPositionValues[currentPositionIndex]
    }
    
    func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        
        player?.moveDownwards()
        playerPosition[currentPositionIndex] = 0;
        currentPositionIndex -= 1;
        playerPosition[currentPositionIndex] = 1;
        player?.zPosition = Constants.zPositionValues[currentPositionIndex]
    }
    
    private func scoreAndRemove(enemyBot: SKPhysicsBody) {
        player?.highFive()
        
        // Find the bot that made contact with player
        enemyBots.enumerateChildNodes(withName: (enemyBot.node?.name)!) { (node, stop) in
            if let bot = node as? EnemyBot {
                bot.highFive()
            }
        }
        enemyBots.enumerateChildNodes(withName: (enemyBot.node?.name)!, using: { (node, stop) in
            if let bot = node as? EnemyBot {
                bot.highFive()
                bot.die()
            }
        })
        
        score += 1
    }
    
    private func endGame() {
        if let createBotTimer = enemyBotCreationTimer {
            createBotTimer.invalidate()
        }
        
        enemyBots.speed = 0
        playerContainer.speed = 0
        
        // Show game over view controller
        let gameOverViewController = Util.getViewControllerWith(identifier: Constants.gameOverVCIdentifier)  as! GameOverViewController
        gameOverViewController.view.backgroundColor = .clear
        gameOverViewController.modalPresentationStyle = .overCurrentContext
        
        playViewController.present(gameOverViewController, animated: true, completion: nil)
    }
}
