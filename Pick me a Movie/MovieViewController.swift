//
//  MovieViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 01/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import Cosmos

class MovieViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var posterImageOutlet: UIImageView!
    @IBOutlet weak var loadingOutlet: UIActivityIndicatorView!
    
    @IBOutlet weak var synopsisLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    @IBOutlet weak var starsCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    
    @IBOutlet weak var metascoreRating: CosmosView!
    @IBOutlet weak var imdbRating: CosmosView!

    override func viewDidLoad() {
        self.moviePoster = self.posterImageOutlet
        self.loadingView = self.loadingOutlet
        super.viewDidLoad()
//        starsCollectionView.restorationIdentifier = "starCell"
        starsCollectionView.delegate = self
        starsCollectionView.dataSource = self
        
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let metaScore:Double = Double(self.movie!.metacriticScore)!
        let imdbScore:Double = Double(self.movie!.imdb_score)!
        super.viewWillAppear(animated)
        self.updateMoviePoster()
        self.synopsisLabel.text = self.movie!.synopsis
        self.titleLabel.text = self.movie!.movie_title
        self.countryLabel.text = self.movie!.country
        self.durationLabel.text = self.movie!.duration
        self.yearLabel.text = self.movie!.title_year
        self.metascoreRating.rating =  metaScore / 20
        self.imdbRating.rating = imdbScore / 2
//        self.starsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.starsCollectionView{
            return self.movie!.actors.count
        }
        return self.movie!.genres.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.starsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "starCell", for: indexPath) as! StarCollectionViewCell
            let starName = self.movie!.actors[indexPath.item]
            cell.actorName.text = starName
            return cell
        }
        
        let genre = self.movie!.genres[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreName.text = genre
        return cell
    }
    
  
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
