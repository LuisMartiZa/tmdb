//
//  SearchPage.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class SearchPage {
    var page: Int = 1
    var results: [SearchItem] = []
    var totalResults: Int = 0
    var totalPages: Int = 1
    
    init() { }
    
    init(json: [String: Any]) {
        if let page = json["page"] as? Int {
            self.page = page
        }
        if let results = json["results"] as? [[String: Any]] {
            for result in results {
                if let searchItem = SearchItem(json: result) {
                    self.results.append(searchItem)
                }
            }
        }
        if let totalResults = json["total_results"] as? Int {
            self.totalResults = totalResults
        }
        if let totalPages = json["total_pages"] as? Int {
            self.totalPages = totalPages
        }
    }
}
