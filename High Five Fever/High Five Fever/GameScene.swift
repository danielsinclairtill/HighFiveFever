//
//  GameScene.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-09.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    weak var playViewController: PlayViewController!
    var count = 0
    
    let FILE_NAME_BACKGROUND = "FinalBackground.png"
    let FILE_NAME_PLAYER_N = "PlayerNormal.png"
    let FILE_NAME_PLAYER_HF = "PlayerHF.png"
    let FILE_NAME_ENEMY_BOT_N = "Bot1Normal.png"
    let FILE_NAME_ENEMY_BOT_HF = "Bot1HF.png"
    let gameOverVC = "GameOverVC"
    
    // hardcoded values determined experimentally
    let X_COORD_SCORE_LABEL: CGFloat = 549.67
    let Y_COORD_SCORE_LABEL: CGFloat = 570.786
    let WIDTH_BACKGROUND: CGFloat = 430
    let HEIGHT_BACKGROUND: CGFloat = 766.226
    
    let botPosition: [CGPoint] = [CGPoint(x: 350, y: 130), CGPoint(x: 350, y: 200), CGPoint(x: 350, y: 270), CGPoint(x: 350, y: 340)];
    
    // Factories
    let botFactory: BotFactory = BotFactory()
    
    let sceneFactory: SceneFactory = SceneFactory()
    
    // Global Variables
    var player: PlayerBot?

    var scoreLabel = SKLabelNode()
    
    var playerPosition = [0,1,0,0]
    
    let zPositionValues: [CGFloat] = [4.0, 3.0, 2.0, 1.0]
    
    var currentIndex = 1;
    
    var botCount = 0
    
    var enemyBotCreationTimer: Timer?
    
    var enemyBotMovementTimers = [Timer]()
    
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
        
        // Add background to scene
        let backgroundSize = CGSize(width: WIDTH_BACKGROUND, height: HEIGHT_BACKGROUND)
        let background = sceneFactory.createBackground(filename: FILE_NAME_BACKGROUND, position: setToScreenCenter(self), size: backgroundSize)
        self.addChild(background);
        
        // Set score label
        scoreLabel = sceneFactory.createScoreLabel(position: CGPoint(x: X_COORD_SCORE_LABEL, y: Y_COORD_SCORE_LABEL))
        self.addChild(scoreLabel);
        
        // Set up wall
        let wall: SKNode = sceneFactory.createWallOn(edge: WallEdge.right, of: self)!
        self.addChild(wall)
        
        // Add player bot to scene
        player = botFactory.createPlayerBotWith(normalFilename: FILE_NAME_PLAYER_N, highFiveFilename: FILE_NAME_PLAYER_HF, position: CGPoint(x: 650, y: 200), textureScaledBy: 0.45, physicsBodyScaledBy: 0.25)
        player?.zPosition = zPositionValues[1]
        self.addChild(player!)
    }
    
    /* Helper function to return coordinates of screens center */
    private func setToScreenCenter(_ screen: GameScene) -> CGPoint {
        return CGPoint(x: screen.frame.midX, y: screen.frame.midY);
    }
    
    private func scoreAndRemove(enemyBot: SKPhysicsBody) {
        player?.highFive()
        
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
    
    private func endGame() {
        if let createBotTimer = enemyBotCreationTimer {
            createBotTimer.invalidate()
        }
        
        for eachTimer in enemyBotMovementTimers {
            eachTimer.invalidate()
        }

        // Show game over view controller
        let gameOverViewController = Util.getViewControllerWith(identifier: gameOverVC)  as! GameOverViewController
        gameOverViewController.view.backgroundColor = .clear
        gameOverViewController.modalPresentationStyle = .overCurrentContext
        
        playViewController.present(gameOverViewController, animated: true, completion: nil)
    }

    /* Utility function to add enemy bots to scene and start their animation */
    func addEnemyBot() -> Void {
        botCount += 1
        let positionIndex = Int(arc4random() % 4);
        let bot = botFactory.createEnemyBotWith(normalFilename: FILE_NAME_ENEMY_BOT_N, highFiveFilename: FILE_NAME_ENEMY_BOT_HF, position: botPosition[positionIndex], textureScaledBy: 0.45, physicsBodyScaledBy: 0.3)
        bot.name = "enemy bot \(botCount)"
        bot.zPosition = zPositionValues[positionIndex]
        self.addChild(bot);
        
        // Bot movement
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: bot, selector: #selector(bot.moveBot), userInfo: bot, repeats: true);
        enemyBotMovementTimers.append(timer)
    }
    
    func movePlayerUp(){
        if (playerPosition.last! == 1) { // player is at last spot
            return;
        }

        player?.moveUpwards()
        playerPosition[currentIndex] = 0;
        currentIndex += 1;
        playerPosition[currentIndex] = 1;
        player?.zPosition = zPositionValues[currentIndex]
    }
    
    func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        
        player?.moveDownwards()
        playerPosition[currentIndex] = 0;
        currentIndex -= 1;
        playerPosition[currentIndex] = 1;
        player?.zPosition = zPositionValues[currentIndex]
    }
}
