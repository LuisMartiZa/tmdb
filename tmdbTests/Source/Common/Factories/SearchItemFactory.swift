//
//  SearchItemFactory.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation
@testable import tmdb

class SearchItemFactory {
    static func getSearchItemArrayRandom(with numberElements: Int) -> [SearchItem] {
        var searchItems: [SearchItem] = []
        
        for i in 0..<numberElements {
            let searchItem = SearchItem()
            searchItem.id = String(i)
            searchItems.append(searchItem)
        }
        
        return searchItems
    }
}
