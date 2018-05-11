//
//  PlayerSelectObects.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import Foundation

struct PlayerSelectObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class PlayerSelectObjects: NSObject {
    lazy var players: [PlayerSelectObject] = {
        var players: [PlayerSelectObject] = []
        players.append(PlayerSelectObject.init(name: "regular", imageName: "PlayerNormal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot1Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot2Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot3Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot4Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot5Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot6Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot7Normal"))
        players.append(PlayerSelectObject.init(name: "regular", imageName: "Bot8Normal"))
        return players
    }()
}
