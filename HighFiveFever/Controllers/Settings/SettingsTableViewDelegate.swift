//
//  SettingsTableViewDelegate.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import Foundation

protocol SettingsTableViewDelegate: NSObjectProtocol {
    func musicSettingChanged(musicOn: Bool)
    func soundFXSettingChanged(soundFXOn: Bool)
    func preparePlayerSelection()
}
