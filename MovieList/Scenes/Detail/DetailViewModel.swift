//
//  DetailViewModel.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    
    var movie: Movie? { get }
    
    func viewDidLoad(id: Int)
}

final class DetailViewModel: DetailViewModelProtocol {
    
    private weak var view: DetailViewProtocol?
    private let service: MovieServiceProtocol
    private(set) var movie: Movie?
    
    init(view: DetailViewProtocol,
         service: MovieServiceProtocol = MovieService()) {
        self.view = view
        self.service = service
    }
    
    private func getMovieDetail(id: Int) {
        self.view?.setLoading(isLoading: true)
        service.fetchMovieDetail(id: id) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movie):
                self.movie = movie
                self.view?.setLoading(isLoading: false)
                self.view?.setNavTitle(title: movie.title ?? "")
                self.view?.showMovie(movie: movie)
            case .failure(let error):
                print(error)
                self.view?.onError(title: "Error!", message: ServiceError.movieDetailError.rawValue)
            }
        }
    }
    
    func viewDidLoad(id: Int) {
        getMovieDetail(id: id)
    }
}
