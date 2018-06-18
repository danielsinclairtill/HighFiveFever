//
//  GameScene.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-09.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    weak var playViewController: PlayViewController?
    private var count = 0
    
    private let FILE_NAME_BACKGROUND = "FinalBackground.png"
    private let FILE_NAME_PLAYER_N = "Player1Normal.png"
    private let FILE_NAME_PLAYER_HF = "Player1HF.png"
    
    private let botNormalFileNames: [String] = {
        var list: [String] = []
        for i in 1...GameOptionsKeys.numberOfBots {
            list.append(String(format: "Bot%dNormal.png", i))
        }
        return list
    }()
    
    private let botHFFileNames: [String] = {
        var list: [String] = []
        for i in 1...GameOptionsKeys.numberOfBots {
            list.append(String(format: "Bot%dHF.png", i))
        }
        return list
    }()
    
    // hardcoded values determined by screen size
    private let X_COORD_SCORE_LABEL: CGFloat = 230.0
    private let Y_COORD_SCORE_LABEL: CGFloat = 495.0
    
    // delta movement player
    private let deltaPlayer: CGPoint = CGPoint(x: 0.0, y: 55.0)
    
    // delta movement bot
    private let deltaBot: CGPoint = CGPoint(x: 1.0, y: 0.0)

    // row positions
    private let rowPositions: [CGFloat] = [50, 105, 160, 215]
    
    // bot positions
    private lazy var botPosition: [CGPoint] = {
        return [CGPoint(x: 0, y: rowPositions[0]), CGPoint(x: 0, y: rowPositions[1]), CGPoint(x:0, y: rowPositions[2]), CGPoint(x: 0, y: rowPositions[3])]
    }()
    
    private let botSpeed: CGFloat = 150.0
    private let botSpawnRate: TimeInterval = 0.8
    private let botTextureScale: CGFloat = 0.40
    
    // Factories
    let botFactory: BotFactory = BotFactory()
    let sceneFactory: SceneFactory = SceneFactory()
    
    // Global Variables
    @objc private lazy var player: PlayerBot = {
        return botFactory.createPlayerBotWith(normalFilename: FILE_NAME_PLAYER_N,
                                              highFiveFilename: FILE_NAME_PLAYER_HF,
                                              textureScaledBy: botTextureScale,
                                              delta: deltaPlayer)
    }()
    
    private var scoreLabel = SKLabelNode()
    private var playerPosition = [0,1,0,0]
    private let zPositionValues: [CGFloat] = [4.0, 3.0, 2.0, 1.0]
    private var currentIndex = 1;
    private var botCount = 0
    private var enemyBotCreationTimer: Timer?
    
    /* Scene starting point */
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        
        // Set up Swipe gesture recognizer
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(movePlayerUp))
        swipeUp.direction = .up
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(movePlayerDown))
        swipeDown.direction = .down
        
        self.view?.addGestureRecognizer(swipeUp)
        self.view?.addGestureRecognizer(swipeDown)
        
        // Add background to scene
        let backgroundSize = self.frame.size
        let background = sceneFactory.createBackground(filename: FILE_NAME_BACKGROUND, position: setToScreenCenter(self), size: backgroundSize)
        self.addChild(background);
        
        // Set score label
        scoreLabel = sceneFactory.createScoreLabel(position: CGPoint(x: X_COORD_SCORE_LABEL, y: Y_COORD_SCORE_LABEL))
        self.addChild(scoreLabel);
        
        // Set up wall
        let wall: SKNode = sceneFactory.createWallOn(edge: WallEdge.right, of: self)!
        self.addChild(wall)
        
        initiateScene();
    }
    
    /* Contact between objects occurred */
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        // Game over
        if bodyA.categoryBitMask == ColliderType.wall.rawValue || bodyB.categoryBitMask == ColliderType.wall.rawValue {
            endGame()
        }
        
        // Handle contact between bot and player
        // two cases: bot is bodyA or bodyB
        if bodyA.categoryBitMask == ColliderType.playerBot.rawValue && bodyB.categoryBitMask == ColliderType.enemyBot.rawValue {
            // normal collision disregard zPosition, we need player and bot to be in same zPosition
            if bodyB.node?.zPosition == bodyA.node?.zPosition {
                bodyB.velocity = CGVector(dx: 0, dy: 0)
                scoreAndRemove(enemyBot: bodyB)
            }
        }
        
        if bodyA.categoryBitMask == ColliderType.enemyBot.rawValue && bodyB.categoryBitMask == ColliderType.playerBot.rawValue {
            // normal collision disregard zPosition, we need player and bot to be in same zPosition
            if bodyB.node?.zPosition == bodyA.node?.zPosition {
                bodyA.velocity = CGVector(dx: 0, dy: 0)
                scoreAndRemove(enemyBot: bodyA)
            }
        }
        
    }

    /* Utility function to create scene with initial components */
    private func initiateScene() {
        
        // Add player bot to scene
        player.position = CGPoint(x: self.frame.size.width - player.size.width, y: rowPositions[1] + player.size.height / 2)
        player.zPosition = zPositionValues[1]
        self.addChild(player)
        
        // Create enemy bots
        enemyBotCreationTimer = Timer.scheduledTimer(timeInterval: botSpawnRate, target: self, selector: #selector(addEnemyBot), userInfo: nil, repeats: true);
    }
    
    /* Helper function to return coordinates of screens center */
    private func setToScreenCenter(_ screen: GameScene) -> CGPoint {
        return CGPoint(x: screen.frame.midX, y: screen.frame.midY);
    }
    
    private func scoreAndRemove(enemyBot: SKPhysicsBody) {
        player.highFive()
        
        // Find the bot that made contact with player
        self.enumerateChildNodes(withName: (enemyBot.node?.name)!, using: { (node, stop) in
            if let bot = node as? EnemyBot {
                bot.highFive()
                _ = Timer.scheduledTimer(timeInterval: 0.3, target: bot, selector: #selector(bot.removeFromParent), userInfo: nil, repeats: false)
            }
        })
        
        count += 1
        scoreLabel.text = "\(count)"
    }
    
    func restart() {
        //remove player
        player.removeFromParent()
        
        // remove bots
        for child in children {
            // if the name of the node includes "bot", we know it's a bot to remove from parent
            if child.name?.range(of: "enemyBot") != nil {
                child.removeFromParent()
            }
        }
        
        count = 0
        scoreLabel.text = "\(count)"
        botCount = 0
        playerPosition = [0,1,0,0]
        currentIndex = 1
        initiateScene()
        self.view?.isPaused = false
    }
    
    func endGame() {
        if let createBotTimer = enemyBotCreationTimer {
            createBotTimer.invalidate()
        }
        
        self.view?.isPaused = true
        playViewController?.presentGameOver()
    }

    /* Utility function to add enemy bots to scene and start their animation */
    @objc func addEnemyBot() -> Void {
        botCount += 1
        let positionIndex = Int(arc4random() % 4);
        let botIndex = Int(arc4random() % 9);
        let bot = botFactory.createEnemyBotWith(normalFilename: botNormalFileNames[botIndex],
                                                highFiveFilename: botHFFileNames[botIndex],
                                                textureScaledBy: botTextureScale,
                                                delta: deltaBot)
        bot.name = "enemyBot\(botCount)"
        bot.position = CGPoint(x: -bot.size.width / 2, y: rowPositions[positionIndex] + bot.size.height / 2)
        bot.zPosition = zPositionValues[positionIndex]
        self.addChild(bot);
        
        // Bot movement
        bot.physicsBody?.velocity = CGVector(dx: botSpeed, dy: 0)
    }
    
    @objc func movePlayerUp(){
        if (playerPosition.last! == 1) { // player is at last spot
            return;
        }

        player.moveUpwards()
        playerPosition[currentIndex] = 0;
        currentIndex += 1;
        playerPosition[currentIndex] = 1;
        player.zPosition = zPositionValues[currentIndex]
    }
    
    @objc func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        
        player.moveDownwards()
        playerPosition[currentIndex] = 0;
        currentIndex -= 1;
        playerPosition[currentIndex] = 1;
        player.zPosition = zPositionValues[currentIndex]
    }
}
