//
//  GameScene.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-09.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    weak var playViewController: PlayViewController!;

    let FILE_NAME_BACKGROUND = "FinalBackground.png";
    let FILE_NAME_PLAYER_N = "PlayerNormal.png";
    
    // hardcoded values determined experimentally
    let X_COORD_SCORE_LABEL: CGFloat = 549.67;
    let Y_COORD_SCORE_LABEL: CGFloat = 570.786;
    let WIDTH_BACKGROUND: CGFloat = 430;
    let HEIGHT_BACKGROUND: CGFloat = 766.226;
    
    var background = SKSpriteNode();
    var player = SKSpriteNode();
    var scoreLabel = SKLabelNode();
    
    var playerPosition = [0,1,0,0];
    var currentIndex = 1;
    
    override func didMoveToView(view: SKView) {
        initiateScene();
        setUpGestureRecognizers();
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    /* Utility function to create scene with initial components */
    func initiateScene() {
        // add background to scene
        background = createSpriteNode(FILE_NAME_BACKGROUND);
        background.position = setToScreenCenter(self);
        background.size = CGSizeMake(WIDTH_BACKGROUND, HEIGHT_BACKGROUND);
        background.zPosition = -5;
        self.addChild(background);
        
        // add player to scene
        player = createSpriteNode(FILE_NAME_PLAYER_N);
        player.position = CGPoint(x: 650, y: 200)
        player.setScale(0.45);
        self.addChild(player);
        
        // set score label
        scoreLabel.position = CGPoint(x: X_COORD_SCORE_LABEL, y: Y_COORD_SCORE_LABEL);
        scoreLabel.fontColor = UIColor.blackColor();
        scoreLabel.fontName = "Helvetica";
        scoreLabel.fontSize = 60;
        scoreLabel.text = "0";
        self.addChild(scoreLabel);
        
    }
    
    /* Helper function to create a SKSpriteNode from a image filename */
    func createSpriteNode(fileName: String) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: fileName);
        let node = SKSpriteNode(texture: texture);
        
        return node;
    }
    
    /* Helper function to return coordinates of screens center */
    func setToScreenCenter(screen: GameScene) -> CGPoint {
        return CGPoint(x: CGRectGetMidX(screen.frame), y: CGRectGetMidY(screen.frame));
    }
    
    func setUpGestureRecognizers() {
        // up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)));
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up;
        self.view?.addGestureRecognizer(swipeUp);
        
        // down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)));
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down;
        self.view?.addGestureRecognizer(swipeDown);
    }
    
    func swiped(sender: UISwipeGestureRecognizer){
        // move player
        switch(sender.direction) {
            case UISwipeGestureRecognizerDirection.Up: movePlayerUp();
            case UISwipeGestureRecognizerDirection.Down: movePlayerDown();
            default: break;
        }
    
    }
    
    func movePlayerUp(){
        if(playerPosition.last! == 1) { // player is at last spot
            return;
        }
        let moveUp = SKAction.moveByX(0, y: 70, duration: 0.0);
        player.runAction(moveUp);
        playerPosition[currentIndex] = 0;
        currentIndex += 1;
        playerPosition[currentIndex] = 1;
        
    }
    func movePlayerDown() {
        if (playerPosition.first! == 1){
            return;
        }
        let moveDown = SKAction.moveByX(0, y: -70, duration: 0.0);
        player.runAction(moveDown);
        
        playerPosition[currentIndex] = 0;
        currentIndex -= 1;
        playerPosition[currentIndex] = 1;
    }
}
