//
//  SearchPresenter.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class SearchPresenter {
    // MARK: - Variables
    weak var view: SearchViewProtocol?
    let interactor: SearchInteractorProtocol?
    let wireframe: SearchWireframeProtocol?
    
    var searchs: [SearchItem] = []

    // MARK: - Init
    init(view: SearchViewProtocol?,
         interactor: SearchInteractorProtocol?,
         wireframe: SearchWireframeProtocol?) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfItems(section: Int) -> Int {
        searchs.count
    }
    
    func searchItem(for row: Int) -> SearchItem? {
        if searchs.indices.contains(row) {
            return searchs[row]
        }
        
        return nil
    }
    
    func didSelect(row: Int, section: Int) {
        
    }
    
    func search(_ text: String) {
        
    }
    
    func cleanSearch() {
        
    }
}

// MARK: - Private methods
private extension SearchPresenter {
}
