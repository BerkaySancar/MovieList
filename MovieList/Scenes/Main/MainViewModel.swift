//
//  MainViewModel.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

protocol MainViewModelProtocol {
    
    func viewDidLoad()
    func getUpcomingMovies()
    func getNowPlayingMovies()
}

final class MainViewModel: MainViewModelProtocol {
    
    private weak var view: MainViewProtocol?
    
    func viewDidLoad() {
        
    }
    
    func getUpcomingMovies() {
        
    }
    
    func getNowPlayingMovies() {
        
    }
  
}
