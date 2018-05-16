//
//  SettingsViewController.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/12/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {

    private let userDefaults: UserDefaults = UserDefaults.standard
    private var fowardAnimation: Bool = false
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self

        self.backButton.setImage(#imageLiteral(resourceName: "BackButton"), for: .normal)
        self.backButton.setImage(#imageLiteral(resourceName: "BackButtonPress"), for: .highlighted)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimation(forward: fowardAnimation)
    }
    
    // assign main settings controller as delegate for embedded table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
            
        case let settingsTableViewController as SettingsTableViewController:
            settingsTableViewController.settingsTableViewDelegate = self
        default:
            break
        }
    }
}

extension SettingsViewController: SettingsTableViewDelegate {
    func musicSettingChanged(musicOn: Bool) {
        userDefaults.set(musicOn, forKey: UserDefaultsKeys.settingsMusicKey)
    }
    
    func soundFXSettingChanged(soundFXOn: Bool) {
        userDefaults.set(soundFXOn, forKey: UserDefaultsKeys.settingsSoundFXKey)
    }
    
    func preparePlayerSelection() {
        guard let storyboard = self.storyboard else { return }
        let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.PlayerSelectViewController) as! SettingsPlayerSelectViewController
        viewController.settingsPlayerCollectionViewDelegate = self
        
        fowardAnimation = true
        self.navigationController?.pushViewController(viewController, animated: true)
        fowardAnimation = false
    }
}

extension SettingsViewController: SettingsPlayerCollectionViewDelegate {
    func playerSelected(playerIndex: Int) {
        userDefaults.set(playerIndex, forKey: UserDefaultsKeys.settingsPlayerIndex)
    }
}
