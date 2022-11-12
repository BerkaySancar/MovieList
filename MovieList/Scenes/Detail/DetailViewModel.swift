//
//  DetailViewModel.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    
    func getMovieDetail(id: Int)
}

final class DetailViewModel: DetailViewModelProtocol {
    
    private weak var view: DetailViewProtocol?
    private let service: MovieServiceProtocol
    
    init(view: DetailViewProtocol,
         service: MovieServiceProtocol = MovieService()) {
        self.view = view
        self.service = service
    }
    
    func getMovieDetail(id: Int) {
        self.view?.setLoading(isLoading: true)
        service.fetchMovieDetail(id: id) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movie):
                self.view?.setLoading(isLoading: false)
                self.view?.showMovie(movie: movie)
            case .failure(let error):
                print(error)
            }
        }
    }
}
