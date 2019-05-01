//
//  ViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 30/04/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayView: CardView!
    
    var isPanning: Bool!
    var isPresentingOverlay: Bool!
    
    var startingTransform: CGAffineTransform!
    var point: CGPoint!
    
    let overlayView: CircularView = {
        let ret = CircularView()
        ret.translatesAutoresizingMaskIntoConstraints = false
        print("Returning circular view")
        return ret
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func presentOverlay(){
//        self.overlayView.alpha = 0
        self.view.addSubview(overlayView)
        
        self.setupOverlay()
        let to = self.overlayView.transform
        self.overlayView.transform = to.scaledBy(x: 0, y: 0)
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            self.overlayView.transform = to
        }, completion: nil)
        
    }
    func removeOverlay(){
        //TODO: Animation
            self.overlayView.removeFromSuperview()
    }
    
    func onPanStarted(x: CGFloat){
        self.isPanning = true
        self.startingTransform = self.displayView.transform
//        self.lastPoint = x
        self.presentOverlay()
//        self.lastPoint =
    }
    
    func onPanChanged(transform : CGPoint){
        let x = transform.x
        let y = transform.y
    
        let divParam = self.view.frame.width/2/0.31
        UIView.animate(withDuration: 0.1) {
            let div = x
            let tmp = CGAffineTransform(rotationAngle: ( div)/divParam).translatedBy(x: x, y: y)
            self.displayView.transform = tmp
        }
        
    }
    
    func onPanEnded(){
        self.isPanning = false
//        self.displayView = CGAffineTransform(rotationAngle: 30.0)
        UIView.animate(withDuration: 0.5) {
            self.displayView.transform = self.startingTransform
        }
        self.removeOverlay()
        
    }

    @IBAction func onTapped(_ sender: Any) {
        let gesture = sender as! UIPanGestureRecognizer
//        print("View is being panned", gesture)
        let translation = gesture.translation(in: self.displayView)
        self.point = translation
//        print("translation", translation)≈
        switch gesture.state {
        case .began:
            self.onPanStarted(x: translation.x)
        case .changed:
            self.onPanChanged(transform: translation)
        case .ended:
            self.onPanEnded()
        default:
            break
        }
    }
    
    func setupOverlay(){
        self.overlayView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.overlayView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.overlayView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        self.overlayView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
}

