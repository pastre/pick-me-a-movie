//
//  BaseViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 03/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var movie: Movie?
    var moviePoster: UIImageView!
    var loadingView: UIActivityIndicatorView!

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    func updateMoviePoster(){ // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
        if self.movie?.image != nil{
            self.moviePoster.image = self.movie?.image
            return
        }
        self.loadingView.startAnimating()
        let url = URL(string: self.movie!.imageSrc)!
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                let downloadedImage = UIImage(data: data)
                self.moviePoster.image = downloadedImage
                self.movie?.image = downloadedImage
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
