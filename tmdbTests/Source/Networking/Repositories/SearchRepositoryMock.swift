//
//  SearchRepositoryMock.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import PromiseKit
@testable import tmdb

class SearchRepositoryMock: SearchRepositoryProtocol {
    
    var getSearchListCalled = false
    
    func getSearchList(by text: String, page: Int) -> Promise<[String : Any]> {
        getSearchListCalled = true
        return Promise<[String: Any]> { seal in
            seal.fulfill([:])
        }
    }
}
