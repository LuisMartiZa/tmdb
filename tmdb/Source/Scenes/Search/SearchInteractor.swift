//
//  SearchInteractor.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import PromiseKit

enum SearchInteractorError: Error {
    case getSearchListError(String)
}

class SearchInteractor {
    private let repository: SearchRepositoryProtocol!
    private var lastPage: SearchPage?
    
    init(_ repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func getSearchList(by text: String) -> Promise<[SearchItem]> {
        return Promise<[SearchItem]> { seal in
            repository.getSearchList(by: text).done { json in
                let page = SearchPage(json: json)
                self.lastPage = page
                
                seal.fulfill(page.results)
            }.catch { error in
                seal.reject(SearchInteractorError.getSearchListError(error.localizedDescription))
            }
        }
    }
}

private extension SearchInteractor {
}
