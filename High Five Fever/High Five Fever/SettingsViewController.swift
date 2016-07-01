//
//  SettingsViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-25.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var menuMusicSwitch: UISwitch!
    
    @IBAction func menuMusicSwitched(sender: UISwitch) {
        
        if (!sender.on) {
            AudioManager.sharedInstance.stopMusic();
        } else {
            AudioManager.sharedInstance.playMusic();
        }
        
        NSUserDefaults.standardUserDefaults().setBool(sender.on, forKey: "isMenuMusicPlaying");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isMusicPLaying = NSUserDefaults.standardUserDefaults().objectForKey("isMenuMusicPlaying") as! Bool;
        
        menuMusicSwitch.on = isMusicPLaying;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
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
