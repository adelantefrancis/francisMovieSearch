//
//  Movie.swift
//  MovieSeach
//
//  Created by Francis Adelante on 6/17/22.
//

import Foundation

struct MovieResponse: Decodable {
    let movies: [Movie]
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
     
}
struct Movie: Decodable  {
    let imdbId: String
    let title: String
    let poster: String
    let year: String
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
        case type = "Type"
    }
}
