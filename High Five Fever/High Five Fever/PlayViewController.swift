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
        
        // turn menu music off
        AudioManager.sharedInstance.stopMusic();
        AudioManager.sharedInstance.enteredFromPlayView = false;
        
        // turn game music on
        // check if user has game music muted
        if(NSUserDefaults.standardUserDefaults().objectForKey("isGameMusicSet") as! Bool){
            AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.gameSongName);
            AudioManager.sharedInstance.playMusic();
            AudioManager.sharedInstance.lastPlayedWasMenuSong = false;
        }
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            currentGame = scene;
            scene.playViewController = self;
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
