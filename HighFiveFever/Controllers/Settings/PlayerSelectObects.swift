//
//  PlayerSelectObects.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import Foundation

struct PlayerSelectObject {
    let gameImageName: String
    let gameHFImageName: String
    let selectImageName: String
    
    init(gameImageName: String, gameHFImageName: String, selectImageName: String) {
        self.gameImageName = gameImageName
        self.gameHFImageName = gameHFImageName
        self.selectImageName = selectImageName
    }
}

class PlayerSelectObjects: NSObject {
    lazy var players: [PlayerSelectObject] = {
        var players: [PlayerSelectObject] = []
        players.append(PlayerSelectObject.init(gameImageName: "Player1Normal", gameHFImageName: "Player1HF", selectImageName: "Player1NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot1Normal", gameHFImageName: "Bot1HF", selectImageName: "Bot1NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot2Normal", gameHFImageName: "Bot2HF", selectImageName: "Bot2NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot3Normal", gameHFImageName: "Bot3HF", selectImageName: "Bot3NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot4Normal", gameHFImageName: "Bot4HF", selectImageName: "Bot4NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot5Normal", gameHFImageName: "Bot5HF", selectImageName: "Bot5NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot6Normal", gameHFImageName: "Bot6HF", selectImageName: "Bot6NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot7Normal", gameHFImageName: "Bot7HF", selectImageName: "Bot7NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot8Normal", gameHFImageName: "Bot8HF", selectImageName: "Bot8NormalPS"))
        players.append(PlayerSelectObject.init(gameImageName: "Bot9Normal", gameHFImageName: "Bot9HF", selectImageName: "Bot9NormalPS"))
        return players
    }()
}
