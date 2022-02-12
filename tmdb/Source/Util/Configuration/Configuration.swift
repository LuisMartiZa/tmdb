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
}

enum URLs {
    case baseURL
    
    func value() -> URL {
        switch self {
        case .baseURL:
            return URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Secret.apiKey.rawValue)")!
        }
    }
}
