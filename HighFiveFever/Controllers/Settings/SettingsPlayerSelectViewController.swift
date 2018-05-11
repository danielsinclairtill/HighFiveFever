//
//  SettingsPlayerSelectViewController.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class SettingsPlayerSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var playerSelectCollectionView: UICollectionView!
    private let playerSelectObects = PlayerSelectObjects()
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let padding = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = playerSelectCollectionView.frame.width - padding
        let itemWidth = availableWidth / itemsPerRow
        
        layout.sectionInset = sectionInsets
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        playerSelectCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerSelectObects.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = playerSelectCollectionView.dequeueReusableCell(withReuseIdentifier: "playerSelectCell", for: indexPath) as! PlayerSelectCollectionViewCell
        let cellImageName = playerSelectObects.players[indexPath.row].imageName
        cell.displayContent(imageName: cellImageName)
        
        return cell
    }

}

