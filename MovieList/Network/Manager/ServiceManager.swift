//
//  ServiceManager.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Alamofire
import Foundation

final class ServiceManager {
    
    static let shared = ServiceManager()
    
    private init() {}
}

extension ServiceManager {
    func sendRequest<T: Codable>(type: T.Type,
                                 url: String,
                                 method: HTTPMethod,
                                 completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(url,
                   method: method,
                   encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
    
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
