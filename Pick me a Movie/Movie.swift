//
//  Movie.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 01/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation

class Movie{
    internal init(director_name: String?, num_critic_for_reviews: String?, duration: String?, actor_2_name: String?, genres: String?, actor_1_name: String?, movie_title: String?, num_voted_users: String?, actor_3_name: String?, plot_keywords: String?, movie_imdb_link: String?, country: String?, content_rating: String?, title_year: String?, imdb_score: String?, movie_facebook_likes: String?, synopsis: String?, imageSrc: String?, metacriticScore: String?) {
        self.director_name = director_name
        self.num_critic_for_reviews = num_critic_for_reviews
        self.duration = duration
        self.actor_2_name = actor_2_name
        self.genres = genres
        self.actor_1_name = actor_1_name
        self.movie_title = movie_title
        self.num_voted_users = num_voted_users
        self.actor_3_name = actor_3_name
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
    }
    
    
    public var description: String { return "Movie: \(self.movie_title!)" }
    
    var director_name: String!
    var num_critic_for_reviews: String!
    var duration: String!
    var actor_2_name: String!
    var genres: String!
    var actor_1_name: String!
    var movie_title: String!
    var num_voted_users: String!
    var actor_3_name: String!
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
    
}
