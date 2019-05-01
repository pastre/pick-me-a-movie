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
    
//    var iconLocation: [String : UIImageView] = [String : UIImageView]()
    
    var hasSetup = false
    var currentSelection: String!
    
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
    
    func updateSelectedIcons(at point: CGPoint){
//        print("Point is", point)
        let x = point.x
        let y = point.y
        var mapTouch: String! = ""
        
        if x > 0{
            self.liked.image = UIImage(named: "likedSelected")
            self.disliked.image = UIImage(named: "disliked")
            mapTouch += ("r")
        }else{
            self.liked.image = UIImage(named: "liked")
            self.disliked.image = UIImage(named: "dislikedSelected")
            mapTouch += ("l")
        }
    
        if y < 0{
            self.watched.image = UIImage(named: "watchedSelected")
            self.unwatched.image = UIImage(named: "unwatched")
            mapTouch += ("t")
        }else {
            self.watched.image = UIImage(named: "watched")
            self.unwatched.image = UIImage(named: "unwatchedSelected")
            mapTouch += ("b")
        }
//        print("Map touch is", mapTouch, self.currentSelection ?? "espera ai")
        self.currentSelection = mapTouch
        
    }
    
    func animateSelectedIcons(){
        let transformScale: CGFloat = 4
        
        let isTop = self.currentSelection.contains("t")
        let isLeft = self.currentSelection.contains("l")
        
        let transformUpwards = isTop ? watched : unwatched
        let transformSides = isLeft ? disliked : liked
        
        UIView.animate(withDuration: 0.8, animations: {
            transformUpwards.transform = transformUpwards.transform.scaledBy(x: transformScale, y: transformScale)
            transformUpwards.alpha = 0
        }) { (_) in
            transformUpwards.transform = transformUpwards.transform.scaledBy(x: 1/transformScale, y: 1/transformScale)
            transformUpwards.alpha = 1
        }
        
        UIView.animate(withDuration: 1, animations: {
            transformSides.transform = transformSides.transform.scaledBy(x: transformScale, y: transformScale)
            transformSides.alpha = 0
        }) { (_) in
            transformSides.transform = transformSides.transform.scaledBy(x: 1/transformScale, y: 1/transformScale)
            transformSides.alpha = 1
        }
        

        print(isTop, isLeft)
    }
    
    
    func setupIcons(){
//        self.setupWatchedIcon()
        
        self.setupIcon(imageView: unwatched, at: "tr")
        self.setupIcon(imageView: watched, at: "tl")
        self.setupIcon(imageView: liked, at: "bl")
        self.setupIcon(imageView: disliked, at: "br")
    }
    func setupIcon(imageView: UIImageView, at: String){
        var wFrame, hFrame : CGFloat!
        
        self.addSubview(imageView)
//        iconLocation[at] = imageView
        
        /* Os icones tem esses possiveis posicionamentos
            _______
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
