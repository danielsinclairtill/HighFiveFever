//
//  HomeMenuViewController.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/11/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class HomeMenuViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        self.playButton.setImage(#imageLiteral(resourceName: "PlayButton"), for: .normal)
        self.playButton.setImage(#imageLiteral(resourceName: "PlayButtonPress"), for: .highlighted)
        self.settingsButton.setImage(#imageLiteral(resourceName: "SettingsButton.png"), for: .normal)
        self.settingsButton.setImage(#imageLiteral(resourceName: "SettingsButtonPress.png"), for: .highlighted)
        self.aboutButton.setImage(#imageLiteral(resourceName: "AboutButton"), for: .normal)
        self.aboutButton.setImage(#imageLiteral(resourceName: "AboutButtonPress.png"), for: .highlighted)
    }
    
    @IBAction func playButtonTouched(_ sender: UIButton) {
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimation(forward: true)
    }
}
