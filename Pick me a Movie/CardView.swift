//
//  CardView.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 30/04/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit(){
        self.layer.cornerRadius = 10
        
        
        self.layer.shadowOffset =  CGSize(width: 0, height: 1)   // CGSizeMake(0, 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.2
        self.layer.shadowOpacity = 0.65
//        self.layer.cornerRadius = 1
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
