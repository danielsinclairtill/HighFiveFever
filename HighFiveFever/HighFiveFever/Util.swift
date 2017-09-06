// Class with utility functions
//  Util.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-09-18.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import Foundation
import UIKit

class Util {

    static let storyboardName: String = "Main"
    
    class func getViewControllerWith(identifier: String) -> UIViewController? {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
