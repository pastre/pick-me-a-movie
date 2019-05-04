//
//  MatchViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 03/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class MatchViewController: BaseViewController {

    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    @IBOutlet weak var moviePosterOutlet: UIImageView!
    override func viewDidLoad() {
        self.moviePoster = self.moviePosterOutlet
        self.loadingView = self.activityIndicatorOutlet
        super.viewDidLoad()
        self.updateMoviePoster()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func handleShowMatch(_ sender: Any) {
        let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController" ) as! UITabBarController
        tabBar.selectedIndex = 1
//
        self.present(tabBar, animated: true)
//        tabBar
//        let nav = self.parent!
//        self.dismiss(animated: true) {
//            nav.tabBarController!.selectedIndex = 1
//        }
    }
    
    
    @IBAction func handleKeepSwiping(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        guard let movie = self.movie else{ return }
//        let dest = segue.destination as! MovieViewController
//        dest.movie = movie
    }
 

}
