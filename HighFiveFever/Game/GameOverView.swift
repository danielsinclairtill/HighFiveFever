//
//  GameOverView.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/16/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class GameOverView: UIView {
    
    @IBOutlet var contentView: GameOverView!
    private var viewHeight: CGFloat = 300.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GameOverView", owner: self, options: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 20.0
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.bounds.width),
            self.heightAnchor.constraint(equalToConstant: self.viewHeight),
        ])
        
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: self.bounds.width),
            self.contentView.heightAnchor.constraint(equalToConstant: self.viewHeight),
            self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    weak var gameOverViewDelegate: GameOverViewDelegate?

    @IBAction func restartButtonTouched(_ sender: UIButton) {
        gameOverViewDelegate?.restartGameTouched()
    }
    
    @IBAction func mainMenuButtonTouched(_ sender: UIButton) {
        gameOverViewDelegate?.mainMenuTouched()
    }
}
