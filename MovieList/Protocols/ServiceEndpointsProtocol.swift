//
//  ServiceEndpointsProtocol.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation

protocol ServiceEndpointProtocols {
    
    var baseURLString: String { get }
    var path: String { get }
    var page: String { get }
    var apiKey: String { get }
    var httpMethod: String { get }
}

extension ServiceEndpointProtocols {
    var url: String {
        return baseURLString + path + page + apiKey
    }
}
