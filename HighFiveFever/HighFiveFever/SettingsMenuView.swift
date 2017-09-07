//
//  SettingsMenuView.swift
//  HighFiveFever
//
//  Created by Daniel Till on 9/7/17.
//  Copyright © 2017 Lunet Apps. All rights reserved.
//

import UIKit

protocol SettingsMenuViewDelegate {
    func settingsMenuBackDidTap()
    func settingsMenuSoundDidTap()
}

class SettingsMenuView: UIView {
    
    var delegate:SettingsMenuViewDelegate?
    private let buttonPadding: CGFloat = 10.0
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "BackButton"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "BackButtonPress"), for: .highlighted)
        button.addTarget(self, action: #selector(backDidTap), for: .touchUpInside)
        return button
    }()

    private let soundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "SoundOnButton"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "SoundOnButtonPress"), for: .highlighted)
        button.addTarget(self, action: #selector(soundDidTap), for: .touchUpInside)
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
        addSubview(soundButton)
        addSubview(backButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame: CGRect = CGRect.zero
        
        // backButton
        frame.size = CGSize(width: 50.0, height: 50.0)
        frame.origin.x = 20.0
        frame.origin.y = 10.0
        backButton.frame = frame
        
        // soundButton
        frame.size = CGSize(width: 249.0, height: 85.0)
        frame.origin.x = bounds.width / 2 - frame.width / 2
        frame.origin.y = 30.0
        soundButton.frame = frame
    }
    
    @objc func backDidTap() {
        delegate?.settingsMenuBackDidTap()
    }
    
    @objc func soundDidTap() {
    }
}
