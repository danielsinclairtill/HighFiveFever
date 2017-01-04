//
//  Constants.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2017-01-03.
//  Copyright © 2017 Lunet Apps. All rights reserved.
//

import SpriteKit

enum ColliderType: UInt32 {
    case noContact = 0
    case playerBot = 1;
    case enemyBot = 2;
    case wall = 4;
}

struct Constants {
    static let backgroundFilename = "FinalBackground.png"
    static let playerNormalFilename = "PlayerNormal.png"
    static let playerHighFiveFilename = "PlayerHF.png"
    static let defaultBotNormalFilename = "Bot1Normal.png"
    static let defaultBotHighFiveFilename = "Bot1HF.png"
    static let gameOverVCIdentifier = "GameOverVC"
    
    static let scoreLabelX: CGFloat = 549.67
    static let scoreLabelY: CGFloat = 570.786
    static let backgroundWidth: CGFloat = 430.0
    static let backgroundHeight: CGFloat = 766.226
    
    static let botPosition: [CGPoint] = [CGPoint(x: 350, y: 130), CGPoint(x: 350, y: 200), CGPoint(x: 350, y: 270), CGPoint(x: 350, y: 340)]
    static let zPositionValues: [CGFloat] = [4.0, 3.0, 2.0, 1.0]
}
