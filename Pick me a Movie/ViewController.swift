//
//  ViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 30/04/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var loadingViewOutlet: UIActivityIndicatorView!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var titluloLabel: UILabel!
    
    
    var isPanning: Bool!
    var isPresentingOverlay: Bool!
    
    var startingTransform: CGAffineTransform!
    var point: CGPoint!
    
    let movieProvider: MovieProvider = MovieProvider.instance
    
    let overlayView: OverlayView = {
        let ret = OverlayView()
        ret.translatesAutoresizingMaskIntoConstraints = false
//        print("Returning circular view")
        return ret
    }()
    
    override func viewDidLoad() {
        self.loadingView = self.loadingViewOutlet
        self.moviePoster = self.posterImageView
        super.viewDidLoad()
        
        self.changeMovie()
        // Do any additional setup after loading the view.
    }

    func changeMovie(){
        let newMovie = self.movieProvider.getMovie()
        self.movie = newMovie
        self.updateMoviePoster()
        self.titluloLabel.text = self.movie!.movie_title
        self.anoLabel.text = self.movie!.title_year
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
    func removeOverlay(selected: Bool){
        //TODO: Animation
        self.overlayView.animateSelectedIcons()
        UIView.animate(withDuration: 0.8, animations: {
            self.overlayView.alpha = 0
        }) { (completed) in
            self.overlayView.alpha = 1
            self.overlayView.removeFromSuperview()
            if selected {
                self.changeMovie()
            }
        }

    }
    
    func onPanStarted(x: CGFloat){
        self.isPanning = true
        self.startingTransform = self.cardView.transform
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
            self.cardView.transform = tmp
        }
        self.overlayView.updateSelectedIcons(at: transform)
    }
    
    func onPanEnded(){
        self.isPanning = false
//        self.displayView = CGAffineTransform(rotationAngle: 30.0)
        UIView.animate(withDuration: 0.5) {
            self.cardView.transform = self.startingTransform
        }
       
        if self.overlayView.currentSelection.isEmpty{
            self.removeOverlay(selected: false)
           return
        }
        
        self.removeOverlay(selected: true)
        
        
        guard let rec = self.movieProvider.getRecomendation() else{
            return
        }
        self.performSegue(withIdentifier: "onMatch", sender: rec)
        
//        self.performSegue(withIdentifier: "movieDetails", sender: nil)
    }

    @IBAction func onTapped(_ sender: Any) {
        let gesture = sender as! UIPanGestureRecognizer
//        print("View is being panned", gesture)
        let translation = gesture.translation(in: self.cardView)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movie = sender as! Movie
        let dest = segue.destination as! BaseViewController
        dest.movie = movie
    }
    
}

