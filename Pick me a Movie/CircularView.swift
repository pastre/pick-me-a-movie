//
//  CircularView.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 30/04/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class CircularView: UIView {
    
    let watched: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let image: UIImage = UIImage(named: "watched")!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        return imageView
    }()

    let unwatched: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let image: UIImage = UIImage(named: "unwatched")!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        return imageView
    }()
    
    let liked: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let image: UIImage = UIImage(named: "liked")!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        return imageView
    }()
    
    let disliked: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let image: UIImage = UIImage(named: "disliked")!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        return imageView
    }()
    
    var hasSetup = false
    
    override func layoutSubviews() {
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = self.frame.width / 2
        if !self.hasSetup{
            self.setupIcons()
            self.hasSetup = true
        }
    }
    
    func updateSelectedIcons(){
        
    }
    
    func setupIcons(){
//        self.setupWatchedIcon()
        
        self.setupIcon(imageView: unwatched, at: "tl")
        self.setupIcon(imageView: watched, at: "tr")
        self.setupIcon(imageView: liked, at: "br")
        self.setupIcon(imageView: disliked, at: "bl")
    }
    
    
    func setupIcon(imageView: UIImageView, at: String){
        let frame = imageView.image!.size
        var wFrame, hFrame : CGFloat!
        let div = self.frame.size.width
        self.addSubview(imageView)
        
        /*  _______
           | tr tl |
           | br bl |
           ---------
         */
        let offset = CGFloat(30)
        switch at {
            case "tl":
                wFrame = offset
                hFrame = -offset
            case "tr":
                wFrame = -offset
                hFrame = -offset
            case "br":
                wFrame = -offset
                hFrame = offset
            
            case "bl":
                wFrame = offset
                hFrame = offset
            default:
                break
        }
        
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
//        imageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 2).isActive = true
//        imageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: wFrame).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: hFrame).isActive = true
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing. 
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
