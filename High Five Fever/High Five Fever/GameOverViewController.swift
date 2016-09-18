//
//  GameOverViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-17.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverViewController: UIViewController {

    @IBAction func restartGame(_ sender: UIButton) {
        self.present(Util.getViewControllerWith(identifier: "PlayVC")!, animated: true, completion: nil)
    }
    
    @IBAction func backToMainMenu(_ sender: UIButton) {
        self.present(Util.getViewControllerWith(identifier: "mainMenu")!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
