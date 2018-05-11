//
//  PlayerSelectCollectionViewCell.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class PlayerSelectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerSelectImage: UIImageView!
    
    func displayContent(imageName: String) {
        playerSelectImage.image = UIImage(named: imageName)
    }
}
