//
//  ViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 30/04/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var moviePosterView: CardView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    var isPanning: Bool!
    var isPresentingOverlay: Bool!
    
    var startingTransform: CGAffineTransform!
    var point: CGPoint!
    
    var currentMovie: Movie?
    let movieProvider: MovieProvider = MovieProvider.instance
    
    let overlayView: CircularView = {
        let ret = CircularView()
        ret.translatesAutoresizingMaskIntoConstraints = false
//        print("Returning circular view")
        return ret
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeMovie()
        
        // Do any additional setup after loading the view.
    }

    func changeMovie(){
        let newMovie = self.movieProvider.getMovie()
        self.currentMovie = newMovie
        self.updateMoviePoster(from: newMovie.imageSrc)
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func updateMoviePoster(from string: String){ // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
        self.loadingView.startAnimating()
        let url = URL(string: string)!
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.moviePoster.image = UIImage(data: data)
                self.loadingView.stopAnimating()
            }
        }
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
        self.overlayView.animateSelectedIcons()                                                                                                                                                                                                                                                                 
        UIView.animate(withDuration: 0.8, animations: {
            self.overlayView.alpha = 0
        }) { (completed) in
            self.overlayView.alpha = 1
            self.overlayView.removeFromSuperview()
            self.changeMovie()
        }

    }
    
    func onPanStarted(x: CGFloat){
        self.isPanning = true
        self.startingTransform = self.moviePosterView.transform
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
            self.moviePosterView.transform = tmp
        }
        self.overlayView.updateSelectedIcons(at: transform)
    }
    
    func onPanEnded(){
        self.isPanning = false
//        self.displayView = CGAffineTransform(rotationAngle: 30.0)
        UIView.animate(withDuration: 0.5) {
            self.moviePosterView.transform = self.startingTransform
        }
        self.removeOverlay()
        
    }

    @IBAction func onTapped(_ sender: Any) {
        let gesture = sender as! UIPanGestureRecognizer
//        print("View is being panned", gesture)
        let translation = gesture.translation(in: self.moviePosterView)
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

