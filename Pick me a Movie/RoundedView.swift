//
//  RoundedView.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 02/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
