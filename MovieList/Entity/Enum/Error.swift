//
//  Errors.swift
//  MovieList
//
//  Created by Berkay Sancar on 12.11.2022.
//

import Foundation

enum ServiceError: String, Error {
    
    case upcomingFetchError = "The upcoming movies cannot be loaded."
    case nowPlayingFetchError = "The nowplaying movies cannot be loaded."
    case movieDetailError = "The movie detail cannot be loaded."
}
