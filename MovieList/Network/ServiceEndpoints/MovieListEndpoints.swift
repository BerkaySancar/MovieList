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
    case imageUrl(posterPath: String)
    
    var baseURLString: String {
        switch self {
        case .upcomingMovies:
            return "https://api.themoviedb.org/3/movie"
        case .nowPlayingMovies:
            return "https://api.themoviedb.org/3/movie"
        case .movieDetail:
            return "https://api.themoviedb.org/3/movie"
        case .imageUrl:
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "/upcoming?"
        case .nowPlayingMovies:
            return "/now_playing?"
        case .movieDetail(let id):
            return "/\(id)?"
        case .imageUrl(let posterPath):
            return "\(posterPath)"
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
        case .imageUrl:
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
        case .imageUrl:
            return ""
        }
    }
    
    var apiKey: String {
        switch self {
        case .upcomingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .nowPlayingMovies:
            return "&api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .movieDetail:
            return "api_key=3d4171de9e5ec5cba7e23c76ec870a0a"
        case .imageUrl:
            return ""
        }
    }
}
