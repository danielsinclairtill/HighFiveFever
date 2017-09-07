//
//  MainMenuView.swift
//  High Five Fever
//
//  Created by Daniel Till on 9/6/17.
//  Copyright © 2017 Lunet Apps. All rights reserved.
//

import UIKit

protocol MainMenuViewDelegate {
    func mainMenuPlayDidTap()
    func mainMenuSettingsDidTap()
    func mainMenuAboutDidTap()
}

class MainMenuView: UIView {

    var delegate: MainMenuViewDelegate?
    private let buttonPadding: CGFloat = 10.0
    private let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "PlayButton"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "PlayButtonPress"), for: .highlighted)
        button.addTarget(self, action: #selector(playDidTap), for: .touchUpInside)
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "SettingsButton.png"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "SettingsButtonPress.png"), for: .highlighted)
        button.addTarget(self, action: #selector(settingsDidTap), for: .touchUpInside)
        return button
    }()
    
    private let aboutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "AboutButton"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "AboutButtonPress.png"), for: .highlighted)
        button.addTarget(self, action: #selector(aboutDidTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(playButton)
        addSubview(settingsButton)
        addSubview(aboutButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame: CGRect = CGRect.zero
        
        // playButton
        frame.size = CGSize(width: 249.0, height: 85)
        frame.origin.x = bounds.width / 2 - frame.width / 2
        frame.origin.y = 30.0
        playButton.frame = frame
        
        // settingsButton
        frame.size = CGSize(width: 249.0, height: 85)
        frame.origin.x = bounds.width / 2 - frame.width / 2
        frame.origin.y = playButton.frame.maxY + buttonPadding
        settingsButton.frame = frame
        
        // aboutButton
        frame.size = CGSize(width: 249.0, height: 85)
        frame.origin.x = bounds.width / 2 - frame.width / 2
        frame.origin.y = settingsButton.frame.maxY + buttonPadding
        aboutButton.frame = frame
    }
    
    @objc private func playDidTap() {
        delegate?.mainMenuPlayDidTap()
    }
    
    @objc private func settingsDidTap() {
        delegate?.mainMenuSettingsDidTap()
    }
    
    @objc private func aboutDidTap() {
        delegate?.mainMenuAboutDidTap()
    }
}
