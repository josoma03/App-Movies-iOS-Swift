//
//  Constants.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
struct Constants {
    static let KeyAPI           = "1a34751954e7a8f93dbe1c97d3ac882d"
    static let TokenAPI           = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTM0NzUxOTU0ZTdhOGY5M2RiZTFjOTdkM2FjODgyZCIsInN1YiI6IjViZjI0MDMwYzNhMzY4MThhMzA3ZjA0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LhM7JYAdieGdZJGgFblNEPU5jg7SkLtaZVqoFwrMQC4"
    static let ApiURL           = "https://api.themoviedb.org/3/{path}?api_key={key}"
    static let ImageURL        = "https://image.tmdb.org/t/p"
    
    static let PosterSizes = [
        "w92",
        "w154",
        "original"]
    
    struct Movies {
        struct Upcoming {
            static let Path = "movie/upcoming"
        }
        struct TopRated {
            static let Path = "movie/top_rated"
        }
        struct Popular {
            static let Path = "movie/popular"
        }
        struct Details {
            static let Path = "movie/{id}"
        }
        
        
    }
}


