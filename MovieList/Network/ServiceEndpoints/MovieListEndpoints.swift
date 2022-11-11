//
//  MovieListEndpoints.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

enum MovieListEndpoints: ServiceEndpointProtocols {
    
case upcomingMovies(page: Int)
case nowPlayingMovies(page: Int)
    
    var baseURLString: String {
        switch self {
        case .upcomingMovies:
            return "https://api.themoviedb.org/3/movie"
        case .nowPlayingMovies:
            return "https://api.themoviedb.org/3/movie"
        }
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "/upcoming?"
        case .nowPlayingMovies:
            return "/now_playing?"
        }
    }
    
    var page: String {
        switch self {
        case .upcomingMovies(let page):
            return "page=\(page)"
        case .nowPlayingMovies(let page):
            return "page=\(page)"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .upcomingMovies:
            return "GET"
        case .nowPlayingMovies:
            return "GET"
        }
    }
    
    var apiKey: String {
        switch self {
        case .upcomingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .nowPlayingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        }
    }
}
