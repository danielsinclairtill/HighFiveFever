//
//  PlayViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-25.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit
import SpriteKit

class PlayViewController: UIViewController {
    
    var currentGame: GameScene!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScene()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func prepareForUnwindFromGameScene(_ segue: UIStoryboardSegue) {
        if segue.source is GameOverViewController {
            self.loadScene()
        }
        
        return
    }
    
    private func loadScene() {
        // turn menu music off
        AudioManager.sharedInstance.stopMusic();
        AudioManager.sharedInstance.enteredFromPlayView = false;
        
        // turn game music on
        // check if user has game music muted
        if(UserDefaults.standard.object(forKey: "isGameMusicSet") as! Bool){
            AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.gameSongName);
            AudioManager.sharedInstance.playMusic();
            AudioManager.sharedInstance.lastPlayedWasMenuSong = false;
        }
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            currentGame = scene;
            scene.playViewController = self;
        }
    }
}
