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
    
    // File name constants
    let FILE_NAME_BACKGROUND = "FinalBackground.png"
    let FILE_NAME_PLAYER_N = "PlayerNormal.png"
    let FILE_NAME_PLAYER_HF = "PlayerHF.png"
    let FILE_NAME_ENEMY_BOT_N = "Bot1Normal.png"
    let FILE_NAME_ENEMY_BOT_HF = "Bot1HF.png"
    
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
    
    var playerPosition = [0,1,0,0];

    var currentIndex = 1;
    
    var botCount = 0
    
    /* Scene starting point */
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        
        initiateScene();
        
        // Create enemy bots
        _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(addEnemyBot), userInfo: nil, repeats: true);
    }
    
    /* Contact between objects occurred */
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == ColliderType.playerBot.rawValue || bodyB.categoryBitMask == ColliderType.playerBot.rawValue {
            player?.highFive()
        }
        // Find the bot that made contact with player
        if bodyB.categoryBitMask == ColliderType.enemyBot.rawValue  {
            self.enumerateChildNodes(withName: (bodyB.node?.name)!, using: { (node, stop) in
                if let bot = node as? EnemyBot {
                    bot.highFive()
                    // Wait half a second before getting rid of bot
                    _ = Timer.scheduledTimer(timeInterval: 0.5, target: bot, selector: #selector(bot.removeFromParent), userInfo: nil, repeats: false)
                }
            })
        }
        
        count += 1
        scoreLabel.text = "\(count)"
    }

    /* Utility function to create scene with initial components */
    func initiateScene() {
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
        
        // Add player bot to scene
        player = botFactory.createPlayerBotWith(normalFilename: FILE_NAME_PLAYER_N, highFiveFilename: FILE_NAME_PLAYER_HF, position: CGPoint(x: 650, y: 200), textureScaledBy: 0.45, physicsBodyScaledBy: 0.2)
        self.addChild(player!)
    }
    
    /* Utility function to add enemy bots to scene and start their animation */
    func addEnemyBot() -> Void {
        botCount += 1
        let positionIndex = Int(arc4random() % 4);
        let bot = botFactory.createEnemyBotWith(normalFilename: FILE_NAME_ENEMY_BOT_N, highFiveFilename: FILE_NAME_ENEMY_BOT_HF, position: botPosition[positionIndex], textureScaledBy: 0.45, physicsBodyScaledBy: 0.3)
        bot.name = "enemy bot \(botCount)"
        self.addChild(bot);
        
        // Bot movement
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: bot, selector: #selector(bot.moveBot), userInfo: bot, repeats: true);
    }
    
    
    /* Helper function to return coordinates of screens center */
    func setToScreenCenter(_ screen: GameScene) -> CGPoint {
        return CGPoint(x: screen.frame.midX, y: screen.frame.midY);
    }

    func movePlayerUp(){
        if (playerPosition.last! == 1) { // player is at last spot
            return;
        }

        player?.moveUpwards()
        playerPosition[currentIndex] = 0;
        currentIndex += 1;
        playerPosition[currentIndex] = 1;
    }
    
    func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        
        player?.moveDownwards()
        playerPosition[currentIndex] = 0;
        currentIndex -= 1;
        playerPosition[currentIndex] = 1;
    }
}
