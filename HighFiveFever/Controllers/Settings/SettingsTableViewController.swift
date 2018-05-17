//
//  SettingsTableViewController.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    weak var settingsTableViewDelegate: SettingsTableViewDelegate?
    
    @IBOutlet weak var playerSelectButton: UIButton!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var soundFXSwitch: UISwitch!
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    private var music: Bool = true
    private var soundFX: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.music = userDefaults.bool(forKey: UserDefaultsKeys.settingsMusicKey)
        self.soundFX = userDefaults.bool(forKey: UserDefaultsKeys.settingsSoundFXKey)
        
        self.musicSwitch.isOn = self.music
        self.soundFXSwitch.isOn = self.soundFX
    }
    
    @IBAction func playerSelectButtonTouched(_ sender: UIButton) {
        settingsTableViewDelegate?.preparePlayerSelection()
    }
    
    @IBAction func musicSwitch(_ sender: UISwitch) {
        settingsTableViewDelegate?.musicSettingChanged(musicOn: sender.isOn)
    }
    
    @IBAction func soundFXSwitch(_ sender: UISwitch) {
        settingsTableViewDelegate?.soundFXSettingChanged(soundFXOn: sender.isOn)
    }
}
