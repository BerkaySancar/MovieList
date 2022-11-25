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
    var page: Int { get set }
    var isScrolling: Bool { get set }
    
    func viewDidLoad()
    func getUpcomingMovies(page: Int)
    func getNowPlayingMovies(page: Int)
    func loadMoreMovies()
}

final class MainViewModel: MainViewModelProtocol {
    
    private weak var view: MainViewProtocol?
    private let service: MovieServiceProtocol
    
    private(set) var upcomingMovies: [Movie] = []
    private(set) var nowPlayingMovies: [Movie] = []
    var page: Int = 1
    var isScrolling = false
    
    // MARK: - Init
    init(view: MainViewProtocol,
         service: MovieServiceProtocol = MovieService()) {
        self.view = view
        self.service = service
    }
    
    // MARK: - func ViewDidLoad
    func viewDidLoad() {
        view?.prepareTableView()
        getUpcomingMovies(page: self.page)
        getNowPlayingMovies(page: self.page)
    }
    
    // MARK: - func getUpcomingMovies
    func getUpcomingMovies(page: Int) {
        view?.setLoading(isLoading: true)
        service.fetchUpcomingMovies(page: page) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movies):
                self.upcomingMovies = movies
                self.view?.refreshTableView()
                self.view?.setLoading(isLoading: false)
            case .failure(let error):
                print(error)
                self.view?.onError(title: "Error!", message: ServiceError.upcomingFetchError.rawValue)
            }
        }
    }
    
    // MARK: - func getNowPlayingMovies
    func getNowPlayingMovies(page: Int) {
        view?.setLoading(isLoading: true)
        service.fetchNowPlayingMovies(page: page) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let movies):
                self.nowPlayingMovies = movies
                self.view?.refreshTableView()
                self.view?.setLoading(isLoading: false)
            case .failure(let error):
                print(error)
                self.view?.onError(title: "Error!", message: ServiceError.nowPlayingFetchError.rawValue)
            }
        }
    }
    
    // MARK: - func loadMoreMovies
    func loadMoreMovies() {
        self.view?.setLoading(isLoading: true)
        if !self.isScrolling {
            self.isScrolling = true
            self.page += 1
            self.service.fetchUpcomingMovies(page: self.page) { [weak self] results in
                guard let self else { return }
                switch results {
                case .success(let movies):
                    for movie in movies {
                        self.upcomingMovies.append(movie)
                    }
                    self.view?.refreshTableView()
                    self.view?.setLoading(isLoading: false)
                case .failure(let error):
                    print(error)
                    self.view?.onError(title: "Error!", message: ServiceError.upcomingFetchError.rawValue)
                }
            }
        }
    }
}
