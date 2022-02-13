//
//  SearchPageFactory.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation
@testable import tmdb

class SearchPageFactory {
    static func getLastPageForLastElement() -> SearchPage {
        let lastPage = SearchPage()
        lastPage.page = 1
        lastPage.totalPages = 1
        
        return lastPage
    }
    
    static func getLastPageRandom() -> SearchPage {
        let lastPage = SearchPage()
        lastPage.page = 1
        lastPage.totalPages = 2
        
        return lastPage
    }
}
