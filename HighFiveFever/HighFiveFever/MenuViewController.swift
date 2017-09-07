//
//  MenuViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-23.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, MainMenuViewDelegate, SettingsMenuViewDelegate {
    
    var music = true
    private let topBaseMenuPadding: CGFloat = 180.0
    private let baseMenuView = BaseMenuView()
    private lazy var mainMenuView: MainMenuView = {
        let view = MainMenuView()
        view.delegate = self
        return view
    }()
    
    private lazy var settingsMenuView: SettingsMenuView = {
        let view = SettingsMenuView()
        view.delegate = self
        view.isHidden = true
        return view
    }()

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
        
        // baseMenuView
        baseMenuView.frame = view.frame
        
        // mainMenuView
        frame.size = CGSize(width: view.frame.width, height: view.frame.height - topBaseMenuPadding)
        frame.origin.x = view.frame.origin.x
        frame.origin.y = view.frame.origin.y + topBaseMenuPadding
        mainMenuView.frame = frame
        
        // settingsMenuView
        frame.size = CGSize(width: view.frame.width, height: view.frame.height - topBaseMenuPadding)
        frame.origin.x = 1.5 * view.bounds.width - frame.width / 2
        frame.origin.y = view.frame.origin.y + topBaseMenuPadding
        settingsMenuView.frame = frame
    }
    
    private func addViews() {
        view.addSubview(baseMenuView)
        view.addSubview(mainMenuView)
        view.addSubview(settingsMenuView)
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
    
    // MARK: MainMenuViewDelegate
    
    func mainMenuPlayDidTap() {
    }
    
    func mainMenuSettingsDidTap() {
        slideIn(fromView: mainMenuView, toView: settingsMenuView)
    }
    
    func mainMenuAboutDidTap() {
    }
    
    // MARK: SettingsMenuDelegate
    
    func settingsMenuBackDidTap() {
        slideOut(fromView: settingsMenuView, toView: mainMenuView)
    }
    
    func settingsMenuSoundDidTap() {
    }
    
    func slideIn(fromView: UIView, toView:UIView){
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
            fromView.frame.origin.x = fromView.frame.origin.x + 50.0
        }, completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                    toView.isHidden = false
                    toView.frame.origin.x = toView.frame.origin.x - self.view.bounds.width
                    
                    fromView.frame.origin.x = fromView.frame.origin.x - self.view.bounds.width - 50.0
                }, completion: { _ in
                        fromView.isHidden = true
                    })
        })
    }
    
    func slideOut(fromView: UIView, toView:UIView){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            toView.isHidden = false
            toView.frame.origin.x = toView.frame.origin.x + self.view.bounds.width + 50.0
            
            fromView.frame.origin.x = fromView.frame.origin.x + self.view.bounds.width
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut], animations: {
                toView.frame.origin.x = toView.frame.origin.x - 50.0
            }, completion: { _ in
                fromView.isHidden = true
            })
        })
    }
}
