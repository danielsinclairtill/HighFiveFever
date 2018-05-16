//
//  SettingsPlayerSelectViewController.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/14/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class SettingsPlayerSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let userDefaults: UserDefaults = UserDefaults.standard
    weak var settingsPlayerCollectionViewDelegate: SettingsPlayerCollectionViewDelegate?

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
        playerSelectCollectionView.dataSource = self
        playerSelectCollectionView.delegate = self
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerSelectObects.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerSelectCollectionView.dequeueReusableCell(withReuseIdentifier: "playerSelectCell", for: indexPath) as! PlayerSelectCollectionViewCell
        let cellImageName = playerSelectObects.players[indexPath.row].imageName
        cell.displayContent(imageName: cellImageName)
        
        // apply selection to cell from saved setting
        if (indexPath.row == userDefaults.integer(forKey: UserDefaultsKeys.settingsPlayerIndex)) {
            self.playerSelectCollectionView.selectItem(at: indexPath, animated: true,
                                                       scrollPosition: UICollectionViewScrollPosition.centeredVertically)
            selectCell(cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = playerSelectCollectionView.cellForItem(at: indexPath) as! PlayerSelectCollectionViewCell
        selectCell(cell)
        settingsPlayerCollectionViewDelegate?.playerSelected(playerIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = playerSelectCollectionView.cellForItem(at: indexPath) as! PlayerSelectCollectionViewCell
        cell.playerSelectImage.layer.borderColor = UIColor.clear.cgColor
    }
    
    func selectCell(_ cell: PlayerSelectCollectionViewCell) {
        cell.playerSelectImage.layer.borderColor = UIColor.black.cgColor
        cell.playerSelectImage.layer.borderWidth = 5.0
        cell.playerSelectImage.layer.cornerRadius = 5.0
    }
}

