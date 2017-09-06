//
//  SplashScreenViewController.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-01.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashImageView: UIImageView!
    var frameCount = 33;
    var timer = Timer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(animateSplashView), userInfo: nil, repeats: true);
        
    }
    
    func animateSplashView(){
        if (frameCount == 0){
            // segue to main menu
            let menuViewController = MenuViewController()
            present(menuViewController, animated: true, completion: nil);
        }
        
        frameCount -= 1;
        splashImageView.image = UIImage(named: "c/(frameCount).png");
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
