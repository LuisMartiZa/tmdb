//
//  SearchViewMock.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation
@testable import tmdb

class SearchViewMock: SearchViewProtocol {
    var reloadDataCalled = false
    var displayErrorCalled = false
    
    func reloadData() {
        reloadDataCalled = true
    }
    
    func displayError(_ error: String) {
        displayErrorCalled = true
    }
}
