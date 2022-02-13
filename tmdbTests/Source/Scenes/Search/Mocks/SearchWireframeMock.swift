//
//  SearchWireframeMock.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation
@testable import tmdb

class SearchWireframeMock: SearchWireframeProtocol{
    var presentMovieDetail = false
    
    func showMovieDetail(_ movieID: String) {
        presentMovieDetail = true
    }
}
