//
//  MenuViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-23.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var music = true
    private let topBaseMenuPadding: CGFloat = 180.0
    private let baseMenuView = BaseMenuView()
    private let mainMenuView = MainMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFrames()
        addViews()

        if(AudioManager.sharedInstance.enteredFromPlayView){
            AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName);
            
            if(UserDefaults.standard.object(forKey: "isMenuMusicSet") as! Bool){
                AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = true;
            }
            AudioManager.sharedInstance.enteredFromPlayView = false;
        }
    }
    
    private func setUpFrames() {
        var frame: CGRect = CGRect.zero

        baseMenuView.frame = view.frame
        
        frame.size = CGSize(width: view.frame.width, height: view.frame.height - topBaseMenuPadding)
        frame.origin.x = view.frame.origin.x
        frame.origin.y = view.frame.origin.y + topBaseMenuPadding
        mainMenuView.frame = frame
    }
    
    private func addViews() {
        view.addSubview(baseMenuView)
        view.addSubview(mainMenuView)
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
                //AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = true;
            }
                
        }
        
        return
    }
    
//    func moveButtons (){
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
//            self.playButton.frame.origin.x = self.playButton.frame.origin.x + 50
//            self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x + 50
//            self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x + 50
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
//                    self.backButton.isHidden = false
//                    self.backButton.frame.origin.x = self.backButton.frame.origin.x - self.view.frame.size.width
//                    
//                    // Settings Buttons
//                    self.settingsSoundButton.isHidden = false
//                    self.settingsSoundButton.frame.origin.x -= self.screenWidth
//                    
//                    // Main Buttons
//                    self.playButton.frame.origin.x = self.playButton.frame.origin.x - self.view.frame.size.width
//                    self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x - self.view.frame.size.width
//                    self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x - self.view.frame.size.width
//                })
//        })
//    }
//    
//    func moveButtonsBack (){
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
//                self.backButton.frame.origin.x = self.backButton.frame.origin.x + self.view.frame.size.width
//            
//                // Settings Buttons
//                self.settingsSoundButton.frame.origin.x = self.settingsSoundButton.frame.origin.x + self.view.frame.size.width
//            
//                self.playButton.frame.origin.x = self.playButton.frame.origin.x + self.view.frame.size.width
//                self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x + self.view.frame.size.width
//                self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x + self.view.frame.size.width
//            
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
//                    self.backButton.isHidden = true
//                    
//                    // Settings Buttons
//                    self.settingsSoundButton.isHidden = true
//                    
//                    self.playButton.frame.origin.x = self.playButton.frame.origin.x - 50
//                    self.settingsButton.frame.origin.x = self.settingsButton.frame.origin.x - 50
//                    self.aboutButton.frame.origin.x = self.aboutButton.frame.origin.x - 50
//                })
//        })
//    }
}
