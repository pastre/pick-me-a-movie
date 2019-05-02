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
    
    let movies: [Movie] = {
        var movies: [Movie] = [Movie]()
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let dicts = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSArray
                for anyDict in dicts{
                    let dict = anyDict as! [String :String]
                    let toAppend = Movie(director_name: dict["director_name"], num_critic_for_reviews: dict["num_critic_for_reviews"], duration: dict["duration"], actor_2_name: dict["actor_2_name"], genres: dict["genres"], actor_1_name: dict["actor_1_name"], movie_title: dict["movie_title"], num_voted_users: dict["num_voted_users"], actor_3_name: dict["actor_3_name"], plot_keywords: dict["plot_keywords"], movie_imdb_link: dict["movie_imdb_link"], country: dict["country"], content_rating: dict["content_rating"], title_year: dict["title_year"], imdb_score: dict["imdb_score"], movie_facebook_likes: dict["movie_facebook_likes"], synopsis: dict["synopsis"], imageSrc: dict["imageSrc"], metacriticScore: dict["metacriticScore"])
                    movies.append(toAppend)
                }
            } catch let error{
                print("Error loading movies", error)
                // handle error
            }
        }
        
        
        return movies
    }()
    
    private init(){    }
    
    func getRecomendation() -> Movie?{
        if(self.presentedMovies.count < 10){
            return nil
        }
        let ret = movies.randomElement()
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
