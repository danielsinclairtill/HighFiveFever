//
//  GameScene.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-09.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    weak var playViewController: PlayViewController!;

    let FILE_NAME_BACKGROUND = "FinalBackground.png";
    let FILE_NAME_PLAYER_N = "PlayerNormal.png";
    let FILE_NAME_PLAYER_HF = "PlayerHF.png";
    
    // hardcoded values determined experimentally
    let X_COORD_SCORE_LABEL: CGFloat = 549.67;
    let Y_COORD_SCORE_LABEL: CGFloat = 570.786;
    let WIDTH_BACKGROUND: CGFloat = 430;
    let HEIGHT_BACKGROUND: CGFloat = 766.226;
    
    var background = SKSpriteNode();
    var player = SKSpriteNode();
    var scoreLabel = SKLabelNode();
    
    var playerPosition = [0,1,0,0];
    let botPosition: [CGPoint] = [CGPoint(x: 350, y: 130), CGPoint(x: 350, y: 200), CGPoint(x: 350, y: 270), CGPoint(x: 350, y: 340)];
    let botImage = ["Bot1Normal.png", ];
    var currentIndex = 1;
    
    var gestureStartPoint: CGPoint?;
    var gestureEndPoint: CGPoint?;
    
    var timer = Timer()
    
    var highFiveAction: SKAction?;
    
    enum ColliderType: UInt32 {
        case playerBot = 1;
        case enemyBot = 2;
        case wall = 3;
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        
        initiateScene();
       // _ = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(startBotAnimation), userInfo: nil, repeats: true);
        
    }

    /* Utility function to create scene with initial components */
    func initiateScene() {
        // add background to scene
        background = createSpriteNode(FILE_NAME_BACKGROUND);
        background.position = setToScreenCenter(self);
        background.size = CGSize(width: WIDTH_BACKGROUND, height: HEIGHT_BACKGROUND);
        //background.zPosition = -5;
        background.size = CGSize(width: WIDTH_BACKGROUND, height: HEIGHT_BACKGROUND);
        background.zPosition = -5;
        self.addChild(background);
        
        // add player to scene
        highFiveAction = createHighFiveAction();
        player = createSpriteNode(FILE_NAME_PLAYER_N);
        player.position = CGPoint(x: 650, y: 200)
        //player.zPosition = 1;
        player.setScale(0.45);
        player.physicsBody = SKPhysicsBody(rectangleOf: (player.size));
        player.physicsBody?.isDynamic = false;
        player.physicsBody?.categoryBitMask = ColliderType.playerBot.rawValue;
        player.physicsBody?.contactTestBitMask = ColliderType.enemyBot.rawValue;
        player.physicsBody?.collisionBitMask = ColliderType.enemyBot.rawValue;
        self.addChild(player);
        
        // set score label
        scoreLabel.position = CGPoint(x: X_COORD_SCORE_LABEL, y: Y_COORD_SCORE_LABEL);
        scoreLabel.fontColor = UIColor.black;
        scoreLabel.fontName = "Helvetica";
        scoreLabel.fontSize = 60;
        scoreLabel.text = "0";
        self.addChild(scoreLabel);
        
        let wall = SKNode()
        wall.position = CGPoint(x: 650, y: 0)
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        wall.physicsBody?.isDynamic = false;
        wall.physicsBody?.categoryBitMask = ColliderType.wall.rawValue
        wall.physicsBody?.collisionBitMask = ColliderType.wall.rawValue
        wall.physicsBody?.contactTestBitMask = ColliderType.wall.rawValue
        let bot = createSpriteNode(botImage[0]);
        bot.position = CGPoint(x: 300, y: 200)
        
        bot.setScale(0.45);
        bot.physicsBody = SKPhysicsBody(rectangleOf: bot.size)
        bot.physicsBody?.isDynamic = false;
        bot.physicsBody?.categoryBitMask = ColliderType.enemyBot.rawValue;
        bot.physicsBody?.contactTestBitMask = ColliderType.wall.rawValue;
        bot.physicsBody?.collisionBitMask = ColliderType.wall.rawValue;
        
        let moveBot = SKAction.moveBy(x: 50, y: 0, duration: 1)
        let moveBotForever = SKAction.repeatForever(moveBot)
        bot.run(moveBotForever)
        
        
        self.addChild(bot);
        
    }
    
    func startBotAnimation() -> Void {
        let positionIndex = Int(arc4random() % 4);
        let bot = createSpriteNode(botImage[0]);
        bot.position = botPosition[positionIndex];
        
        bot.setScale(0.45);
        bot.physicsBody = SKPhysicsBody(rectangleOf: (bot.texture?.size())!)
        bot.physicsBody?.isDynamic = false;
        bot.physicsBody?.categoryBitMask = ColliderType.playerBot.rawValue;
        bot.physicsBody?.contactTestBitMask = ColliderType.playerBot.rawValue;
        bot.physicsBody?.collisionBitMask = ColliderType.playerBot.rawValue;
        self.addChild(bot);
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveBot(timer:)), userInfo: bot, repeats: true);
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("contact between " )
    }
    func moveBot (timer: Timer) -> Void {
        let moveBot = SKAction.moveBy(x: 50, y: 0, duration: 0);

        let bot = timer.userInfo as? SKSpriteNode
        bot?.run(moveBot)
    }
    
    /* Helper function to create a SKSpriteNode from a image filename */
    func createSpriteNode(_ fileName: String) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: fileName);
        let node = SKSpriteNode(texture: texture);
        
        return node;
    }
    
    /* Helper function to return coordinates of screens center */
    func setToScreenCenter(_ screen: GameScene) -> CGPoint {
        return CGPoint(x: screen.frame.midX, y: screen.frame.midY);
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.gestureStartPoint = touch.location(in: self.view);
        }
    }
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            self.gestureEndPoint = touch.location(in: self.view);
            
            if (self.gestureEndPoint!.y > self.gestureStartPoint!.y) {
                
                movePlayerDown();
                
            } else if (self.gestureEndPoint!.y < self.gestureStartPoint!.y) {
                
                movePlayerUp();
                
            } else {
                
                player.run(highFiveAction!);
            }
        }
    }
  
    func movePlayerUp(){
        if (playerPosition.last! == 1) { // player is at last spot
            return;
        }
        
        let moveUp = SKAction.moveBy(x: 0, y: 70, duration: 0.0);
        player.run(moveUp);
        playerPosition[currentIndex] = 0;
        currentIndex += 1;
        playerPosition[currentIndex] = 1;
        
    }
    
    func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        
        let moveDown = SKAction.moveBy(x: 0, y: -70, duration: 0.0);
        player.run(moveDown);
        
        playerPosition[currentIndex] = 0;
        currentIndex -= 1;
        playerPosition[currentIndex] = 1;
    }
    
    func createHighFiveAction() -> SKAction {
        let highFiveTexture = SKTexture(imageNamed: FILE_NAME_PLAYER_HF);
        let normalTexture = SKTexture(imageNamed: FILE_NAME_PLAYER_N);
        
        let highFiveAnimation = SKAction.animate(with: [highFiveTexture, normalTexture], timePerFrame: 0.1);
        
        return highFiveAnimation;
    }
 
}
