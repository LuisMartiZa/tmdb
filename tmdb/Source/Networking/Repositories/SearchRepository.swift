//
//  SearchRepository.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import Alamofire
import PromiseKit

protocol SearchRepositoryProtocol {
    func getSearchList(by text: String, page: Int) -> Promise<[String:Any]>
}

enum SearchRepositoryError: Error {
    case getSearchListError(String)
}

class SearchRepository: SearchRepositoryProtocol {
    func getSearchList(by text: String, page: Int = 1) -> Promise<[String : Any]> {
        let url = URLs.searchURL.value()
                    .appending("query", value: text)
                    .appending("page", value: String(page))
        
        return Promise<[String:Any]> { seal in
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(_):
                    if let json = response.value as? [String:Any] {
                        seal.fulfill(json)
                    } else {
                        seal.reject(SearchRepositoryError.getSearchListError("JSON Malformed"))
                    }
                case .failure(let error):
                    seal.reject(SearchRepositoryError.getSearchListError(error.localizedDescription))
                }
            }
        }
    }
}
