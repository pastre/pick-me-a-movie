//
//  Movie.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 01/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit

class Movie{
    
    internal init( director_name: String?, num_critic_for_reviews: String?, duration: String?, genres: [String]?, movie_title: String?, num_voted_users: String?, plot_keywords: String?, movie_imdb_link: String?, country: String?, content_rating: String?, title_year: String?, imdb_score: String?, movie_facebook_likes: String?, synopsis: String?, imageSrc: String?, metacriticScore: String?, actors: [String]?) {
        self.director_name = director_name
        self.num_critic_for_reviews = num_critic_for_reviews
        self.duration = duration
        self.genres = genres
        self.movie_title = movie_title
        self.num_voted_users = num_voted_users
        self.plot_keywords = plot_keywords
        self.movie_imdb_link = movie_imdb_link
        self.country = country
        self.content_rating = content_rating
        self.title_year = title_year
        self.imdb_score = imdb_score
        self.movie_facebook_likes = movie_facebook_likes
        self.synopsis = synopsis
        self.imageSrc = imageSrc
        self.metacriticScore = metacriticScore
        self.actors = actors
    }
    
    
    
    
    public var description: String { return "Movie: \(self.movie_title!)" }
    
    var image: UIImage?
    var director_name: String!
    var num_critic_for_reviews: String!
    var duration: String!
    var genres: [String]!
    var movie_title: String!
    var num_voted_users: String!
    var plot_keywords: String!
    var movie_imdb_link: String!
    var country: String!
    var content_rating: String!
    var title_year: String!
    var imdb_score: String!
    var movie_facebook_likes: String!
    var synopsis: String!
    var imageSrc: String!
    var metacriticScore: String!
    var actors: [String]!
    
}
