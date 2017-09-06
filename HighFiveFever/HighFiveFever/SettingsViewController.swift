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
    
    @IBAction func menuMusicSwitched(_ sender: UISwitch) {
        
        if (!sender.isOn) {
            AudioManager.sharedInstance.stopMusic();
        } else {
            AudioManager.sharedInstance.playMusic();
        }
        
        UserDefaults.standard.set(sender.isOn, forKey: "isMenuMusicSet");
    }
    
    @IBAction func gameMusicSwitched(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isGameMusicSet");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuMusicSwitch.isOn = UserDefaults.standard.object(forKey: "isMenuMusicSet") as! Bool;
        gameMusicSwitch.isOn = UserDefaults.standard.object(forKey: "isGameMusicSet") as! Bool;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
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
