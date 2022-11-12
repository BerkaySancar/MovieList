//
//  MovieService.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Alamofire
import Foundation

protocol MovieServiceProtocol {
    
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = MovieListEndpoints.upcomingMovies(page: page).url
        
        ServiceManager.shared.sendRequest(type: BaseResponse.self,
                                          url: url,
                                          method: HTTPMethod(rawValue: MovieListEndpoints.upcomingMovies(page: page).httpMethod)) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = MovieListEndpoints.nowPlayingMovies(page: page).url
        
        ServiceManager.shared.sendRequest(type: BaseResponse.self,
                                          url: url,
                                          method: HTTPMethod(rawValue: MovieListEndpoints.nowPlayingMovies(page: page).httpMethod)) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let url = MovieListEndpoints.movieDetail(id: id).url

        ServiceManager.shared.sendRequest(type: Movie.self,
                                          url: url, method: HTTPMethod(rawValue: MovieListEndpoints.movieDetail(id: id).httpMethod)) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
