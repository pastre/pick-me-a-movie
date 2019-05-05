//
//  MovieFacade.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 01/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation

class MovieProvider{
    
    static let instance = MovieProvider()
    
    var presentedMovies: [Movie] = [Movie]()
    var recommendations: [Movie] = [Movie]()
    let movies: [Movie] = {
        var movies: [Movie] = [Movie]()
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let dicts = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSArray
                for anyDict in dicts{
                    let dict = anyDict as! [String : Any]
                    let toAppend = Movie( director_name: (dict["director_name"] as! String), num_critic_for_reviews: (dict["num_critic_for_reviews"] as! String), duration: (dict["duration"] as! String), genres: (dict["genres"] as! [String]), movie_title: (dict["movie_title"] as! String), num_voted_users: (dict["num_voted_users"] as! String), plot_keywords: (dict["plot_keywords"] as! String), movie_imdb_link: (dict["movie_imdb_link"] as! String), country: (dict["country"] as! String), content_rating: (dict["content_rating"] as! String), title_year: (dict["title_year"] as! String), imdb_score: (dict["imdb_score"] as! String), movie_facebook_likes: (dict["movie_facebook_likes"] as! String), synopsis: (dict["synopsis"] as! String), imageSrc: (dict["imageSrc"] as! String), metacriticScore: (dict["metacriticScore"] as! String), actors: (dict["actors"] as! [String]))
                    movies.append(toAppend)
                }
            } catch let error{
                print("Error loading movies", error)
                // handle error
            }
        }
        
        
        return movies
    }()
    
    private init(){}
    
    func getRecomendation() -> Movie?{
        let rand = Int.random(in: 0..<100)
//        return nil
        if(rand > 15){
            return nil
        }
//
        let ret = movies.randomElement()
        self.recommendations.append(ret!)
        return ret
    }
    
    func getMovie() -> Movie{
        var movie: Movie
        repeat{
            movie = self.movies.randomElement()!
        }while self.presentedMovies.contains(where: { (i) -> Bool in
            i.movie_title == movie.movie_title
        })
        self.presentedMovies.append(movie)
        return movie
    }
}
