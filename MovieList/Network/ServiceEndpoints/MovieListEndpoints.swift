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
    case movieDetail(id: Int)
    
    var baseURLString: String {
        switch self {
        case .upcomingMovies:
            return "https://api.themoviedb.org/3/movie"
        case .nowPlayingMovies:
            return "https://api.themoviedb.org/3/movie"
        case .movieDetail:
            return "https://api.themoviedb.org/3/movie"
        }
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "/upcoming?"
        case .nowPlayingMovies:
            return "/now_playing?"
        case .movieDetail(let id):
            return "\(id)?"
        }
    }
    
    var page: String {
        switch self {
        case .upcomingMovies(let page):
            return "page=\(page)"
        case .nowPlayingMovies(let page):
            return "page=\(page)"
        case .movieDetail:
            return ""
        }
    }
    
    var httpMethod: String {
        switch self {
        case .upcomingMovies:
            return "GET"
        case .nowPlayingMovies:
            return "GET"
        case .movieDetail:
            return "GET"
        }
    }
    
    var apiKey: String {
        switch self {
        case .upcomingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .nowPlayingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .movieDetail:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        }
    }
}
