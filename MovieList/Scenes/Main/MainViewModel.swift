//
//  MainViewModel.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

protocol MainViewModelProtocol {
    
    var upcomingMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    
    func viewDidLoad()
    func getUpcomingMovies(page: Int)
    func getNowPlayingMovies(page: Int)
}

final class MainViewModel: MainViewModelProtocol {
    
    private weak var view: MainViewProtocol?
    private let service: MovieServiceProtocol
    
    private(set) var upcomingMovies: [Movie] = []
    private(set) var nowPlayingMovies: [Movie] = []
    
    init(view: MainViewProtocol,
         service: MovieServiceProtocol = MovieService()) {
        self.view = view
        self.service = service
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareCollectionView()
    }
    
    func getUpcomingMovies(page: Int) {
        self.view?.setLoading(isLoading: true)
        service.fetchUpcomingMovies(page: page) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movies):
                self.upcomingMovies = movies
                self.view?.dataRefreshed()
                self.view?.setLoading(isLoading: false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNowPlayingMovies(page: Int) {
        self.view?.setLoading(isLoading: true)
        service.fetchNowPlayingMovies(page: page) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movies):
                self.nowPlayingMovies = movies
                self.view?.dataRefreshed()
                self.view?.setLoading(isLoading: false)
            case .failure(let error):
                print(error)
            }
        }
    }
}
