//
//  SearchWireframe.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit

class SearchWireframe {
    weak var viewController: UIViewController?
}

extension SearchWireframe: SearchWireframeProtocol {
    func showMovieDetail(_ movieID: String) {
        let movieDetailViewController = MovieDetailConfigurator.configureMovieDetailScene(movieID: movieID)
        viewController?.present(movieDetailViewController, animated: true)
    }
}
