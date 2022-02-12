//
//  MovieRepository.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import Alamofire
import PromiseKit

protocol MovieRepositoryProtocol {
    func getMovieDetail(by id: String) -> Promise<[String:Any]>
}

enum MovieRepositoryError: Error {
    case getMovieDetailError(String)
}

class MovieRepository: MovieRepositoryProtocol {
    func getMovieDetail(by id: String) -> Promise<[String : Any]> {
        let url = URLs.movieDetailURL.value(id)

        return Promise<[String:Any]> { seal in
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(_):
                    if let json = response.value as? [String:Any] {
                        seal.fulfill(json)
                    } else {
                        seal.reject(MovieRepositoryError.getMovieDetailError("JSON Malformed"))
                    }
                case .failure(let error):
                    seal.reject(MovieRepositoryError.getMovieDetailError(error.localizedDescription))
                }
            }
        }
    }
}
