//
//  MenuViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-23.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var music = true
    @IBOutlet weak var settingsMusicButton: UIButton!
    @IBOutlet weak var settingsSoundEffectsButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();

        self.backButton.isHidden = true
        self.backButton.frame.origin.x = self.backButton.frame.origin.x + self.view.frame.size.width
        
        // Settings Button
        self.settingsMusicButton.isHidden = true
        self.settingsMusicButton.frame.origin.x = self.settingsMusicButton.frame.origin.x + self.view.frame.size.width
        
        self.settingsSoundEffectsButton.isHidden = true
        self.settingsSoundEffectsButton.frame.origin.x = self.settingsSoundEffectsButton.frame.origin.x + self.view.frame.size.width
        
        self.backButton.setImage(#imageLiteral(resourceName: "BackButton"), for: .normal)
        self.backButton.setImage(#imageLiteral(resourceName: "BackButtonPress"), for: .highlighted)
        self.playButton.setImage(#imageLiteral(resourceName: "PlayButton"), for: .normal)
        self.playButton.setImage(#imageLiteral(resourceName: "PlayButtonPress"), for: .highlighted)
        self.settingsButton.setImage(#imageLiteral(resourceName: "SettingsButton.png"), for: .normal)
        self.settingsButton.setImage(#imageLiteral(resourceName: "SettingsButtonPress.png"), for: .highlighted)
        self.aboutButton.setImage(#imageLiteral(resourceName: "AboutButton"), for: .normal)
        self.aboutButton.setImage(#imageLiteral(resourceName: "AboutButtonPress.png"), for: .highlighted)
        
        self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOn"), for: .normal)
        self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOnPress"), for: .highlighted)

        if(AudioManager.sharedInstance.enteredFromPlayView){
            AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName);
            
            if(UserDefaults.standard.object(forKey: "isMenuMusicSet") as! Bool){
                AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = true;
            }
            AudioManager.sharedInstance.enteredFromPlayView = false;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    
    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue) {
        
        if (segue.source is PlayViewController) {
            AudioManager.sharedInstance.stopMusic();
            AudioManager.sharedInstance.enteredFromPlayView = true;
                
            if(UserDefaults.standard.object(forKey: "isMenuMusicSet") as! Bool){
                AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName)
                AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = true;
            }
                
        }
        
        return
    }
    
    // Main Menu Buttons

    @IBAction func backButtonClicked(_ sender: UIButton) {
        moveButtonsBack()
    }

    @IBAction func settingsButtonClicked(_ sender: UIButton) {
        moveButtons()
    }

    @IBAction func aboutButtonClicked(_ sender: UIButton) {
        moveButtons()
    }
    
    // Setting Buttons
    
    @IBAction func settingsMusicButtonClicked(_ sender: UIButton) {
        if(music){
            music = false
            self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOff"), for: .normal)
            self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOffPress"), for: .highlighted)
        }
        else{
            music = true
            self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOn"), for: .normal)
            self.settingsMusicButton.setImage(#imageLiteral(resourceName: "settingsMusicOnPress"), for: .highlighted)
        }
    }
    
    
    
    
    func moveButtons (){
        
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.playButton.frame.origin.x = self.playButton.frame.origin.x + 50
            self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x + 50
            self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x + 50
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.backButton.isHidden = false
                    self.backButton.frame.origin.x = self.backButton.frame.origin.x - self.view.frame.size.width
                    
                    // Settings Buttons
                    self.settingsMusicButton.isHidden = false
                    self.settingsMusicButton.frame.origin.x = self.settingsMusicButton.frame.origin.x - self.view.frame.size.width
                    
                    self.settingsSoundEffectsButton.isHidden = false
                    self.settingsSoundEffectsButton.frame.origin.x = self.settingsSoundEffectsButton.frame.origin.x - self.view.frame.size.width
                    
                    // Main Buttons
                    self.playButton.frame.origin.x = self.playButton.frame.origin.x - self.view.frame.size.width
                    self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x - self.view.frame.size.width
                    self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x - self.view.frame.size.width
                })
        })
    }
    
    func moveButtonsBack (){
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.backButton.frame.origin.x = self.backButton.frame.origin.x + self.view.frame.size.width
            
                // Settings Buttons
                self.settingsMusicButton.frame.origin.x = self.settingsMusicButton.frame.origin.x + self.view.frame.size.width
                self.settingsSoundEffectsButton.frame.origin.x = self.settingsSoundEffectsButton.frame.origin.x + self.view.frame.size.width
            
                self.playButton.frame.origin.x = self.playButton.frame.origin.x + self.view.frame.size.width
                self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x + self.view.frame.size.width
                self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x + self.view.frame.size.width
            
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.backButton.isHidden = true
                    
                    // Settings Buttons
                    self.settingsMusicButton.isHidden = true
                    self.settingsSoundEffectsButton.isHidden = true
                    
                    self.playButton.frame.origin.x = self.playButton.frame.origin.x - 50
                    self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x - 50
                    self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x - 50
                })
                
                
        })
    }
    
    
    
    
}
