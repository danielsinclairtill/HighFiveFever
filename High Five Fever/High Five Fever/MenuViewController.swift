//
//  MenuViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-23.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if(AudioManager.sharedInstance.enteredFromPlayView){
            AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName);
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("isMenuMusicSet") as! Bool){
                AudioManager.sharedInstance.playMusic();
            }
            AudioManager.sharedInstance.enteredFromPlayView = false;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
