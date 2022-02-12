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
            repository.getSearchList(by: text, page: 1).done { json in
                let page = SearchPage(json: json)
                self.lastPage = page
                
                seal.fulfill(page.results)
            }.catch { error in
                seal.reject(SearchInteractorError.getSearchListError(error.localizedDescription))
            }
        }
    }
    
    func getNextPage(for text: String) -> Promise<[SearchItem]> {
        guard let lastPage = lastPage, isAvailableNextPage() else {
            return Promise<[SearchItem]> { seal in
                seal.fulfill([])
            }
        }
        
        return Promise<[SearchItem]> { seal in
            let nextPage = lastPage.page + 1
            repository.getSearchList(by: text, page: nextPage).done { json in
                let page = SearchPage(json: json)
                self.lastPage = page
                
                seal.fulfill(page.results)
            }.catch { error in
                seal.reject(SearchInteractorError.getSearchListError(error.localizedDescription))
            }
        }
    }
    
    func shouldShowLoadingCell() -> Bool {
        isAvailableNextPage()
    }
}

private extension SearchInteractor {
    func isAvailableNextPage() -> Bool {
        guard let lastPage = lastPage else {
            return false
        }
        
        return lastPage.page < lastPage.totalPages
    }
}
