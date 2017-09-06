//
//  BaseMenuView
//  High Five Fever
//
//  Created by Daniel Till on 9/6/17.
//  Copyright © 2017 Lunet Apps. All rights reserved.
//

import UIKit

class BaseMenuView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9724758267, green: 0.803560853, blue: 0.8027303219, alpha: 1)
        return view
    }()

    private let menuMainImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Title"))
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(backgroundView)
        addSubview(menuMainImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame: CGRect = CGRect.zero
        
        // backgroundView
        backgroundView.frame = bounds

        // menuMainImage
        frame.size = CGSize(width: 388.0, height: 162.0)
        frame.origin.x = bounds.width / 2 - frame.width / 2
        frame.origin.y = 10.0
        menuMainImage.frame = frame
    }
}
