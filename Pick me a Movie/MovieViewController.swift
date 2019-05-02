//
//  MovieViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 01/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var synopsisLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    public var movie: Movie!
    
    @IBOutlet weak var starsCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        starsCollectionView.restorationIdentifier = "starCell"
        starsCollectionView.delegate = self
        starsCollectionView.dataSource = self
        
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateMoviePoster(from: self.movie.imageSrc)
        self.synopsisLabel.text = movie.synopsis
        self.titleLabel.text = movie.movie_title
        self.countryLabel.text = movie.country
        self.durationLabel.text = self.movie.duration
        self.yearLabel.text = self.movie.title_year
//        self.starsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.starsCollectionView{
            return self.movie.actors.count
        }
        return self.movie.genres.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.starsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "starCell", for: indexPath) as! StarCollectionViewCell
            let starName = self.movie.actors[indexPath.item]
            cell.actorName.text = starName
            return cell
        }
        
        let genre = self.movie.genres[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreName.text = genre
        return cell
    }
    
  
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    
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
                self.posterImageView.image = UIImage(data: data)
                self.loadingView.stopAnimating()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
