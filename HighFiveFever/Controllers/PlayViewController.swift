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
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    private var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScene()
    }
    
    private func loadScene() {
        
        // set up game music
        if (userDefaults.bool(forKey: UserDefaultsKeys.settingsMusicKey)) {
            AudioManager.sharedInstance.startGameMusic()
        }
        
        self.scene = GameScene(fileNamed:"GameScene")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene?.scaleMode = .aspectFill
        scene?.size = view.bounds.size
        scene?.playViewController = self;
        skView.presentScene(scene)
    }
    
    @IBAction func menuButtonTouched(_ sender: UIButton) {
        guard let scene = self.scene else { return }
        scene.endGame()
        
        let view = GameOverView()
        view.gameOverViewDelegate = self
        let popup = PopUpViewController(view: view, dismissible: false)
        self.present(popup, animated: true, completion: nil)
    }
}

extension PlayViewController: GameOverViewDelegate {
    func restartGameTouched() {
        // dismiss popup game over view
        self.dismiss(animated: true, completion: nil)
    }
    
    func mainMenuTouched() {
        // dismiss popup game over view
        self.dismiss(animated: true, completion: nil)
        
        if (userDefaults.bool(forKey: UserDefaultsKeys.settingsMusicKey)) {
            AudioManager.sharedInstance.startMenuMusic()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
