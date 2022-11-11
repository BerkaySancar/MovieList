//
//  Movie.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

struct BaseResponse: Codable {
    
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    
    let id: Int
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
