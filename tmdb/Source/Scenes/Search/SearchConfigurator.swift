//
//  SearchConfigurator.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit

class SearchConfigurator {
    class func configureSearchScene() -> SearchViewController {
        let viewController = SearchViewController()
        let interactor = SearchInteractor()
        let wireframe = SearchWireframe()
        let presenter = SearchPresenter(view: viewController,
                                                          interactor: interactor,
                                                          wireframe: wireframe)
        viewController.presenter = presenter
        wireframe.viewController = viewController
        return viewController
    }
}
