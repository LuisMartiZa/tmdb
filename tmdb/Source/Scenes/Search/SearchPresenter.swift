//
//  SearchPresenter.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class SearchPresenter {

    weak var view: SearchViewProtocol?
    let interactor: SearchInteractorProtocol?
    let wireframe: SearchWireframeProtocol?

    init(view: SearchViewProtocol?,
         interactor: SearchInteractorProtocol?,
         wireframe: SearchWireframeProtocol?) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension SearchPresenter: SearchPresenterProtocol {
}

private extension SearchPresenter {
}
