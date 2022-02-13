//
//  Configuration.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

enum Secret: String {
    case apiKey = "9cefd6719c63a7109e0b9fd84615f187"
    case imageBase = "https://image.tmdb.org/t/p/w500"
    case baseURL = "https://api.themoviedb.org/3"
}

enum URLs {
    case searchURL
    case movieDetailURL
    
    func value(_ parameter: String? = nil) -> URL {
        switch self {
        case .searchURL:
            return URL(string: "\(Secret.baseURL.rawValue)/search/movie?api_key=\(Secret.apiKey.rawValue)")!
        case .movieDetailURL:
            return URL(string: "\(Secret.baseURL.rawValue)/movie/\(parameter!)?api_key=\(Secret.apiKey.rawValue)")!
        }
    }
}
