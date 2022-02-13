//
//  SearchInteractorMock.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation
import PromiseKit
@testable import tmdb

class SearchInteractorMock: SearchInteractorProtocol {
    var lastPage: SearchPage!
    
    var getSearchListCalled: Bool = false
    var getNextPageCalled: Bool = false
    var shouldShowLoadingCellCalled: Bool = false
    
    func getSearchList(by text: String) -> Promise<[SearchItem]> {
        getSearchListCalled = true
        
        return Promise<[SearchItem]> { seal in
            seal.fulfill([])
        }
    }
    
    func getNextPage(for text: String) -> Promise<[SearchItem]> {
        getNextPageCalled = true
        
        return Promise<[SearchItem]> { seal in
            seal.fulfill([])
        }
    }
    
    func shouldShowLoadingCell() -> Bool {
        getNextPageCalled = true
        
        return lastPage.page < lastPage.totalPages
    }
}
