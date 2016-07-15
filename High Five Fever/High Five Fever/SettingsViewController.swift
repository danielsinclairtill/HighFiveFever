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
    @IBOutlet weak var gameMusicSwitch: UISwitch!
    
    @IBAction func menuMusicSwitched(sender: UISwitch) {
        
        if (!sender.on) {
            AudioManager.sharedInstance.stopMusic();
        } else {
            AudioManager.sharedInstance.playMusic();
        }
        
        NSUserDefaults.standardUserDefaults().setBool(sender.on, forKey: "isMenuMusicSet");
    }
    
    @IBAction func gameMusicSwitched(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setBool(sender.on, forKey: "isGameMusicSet");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuMusicSwitch.on = NSUserDefaults.standardUserDefaults().objectForKey("isMenuMusicSet") as! Bool;
        gameMusicSwitch.on = NSUserDefaults.standardUserDefaults().objectForKey("isGameMusicSet") as! Bool;
        
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
