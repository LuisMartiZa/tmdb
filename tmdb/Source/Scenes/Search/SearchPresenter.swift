//
//  SearchPresenter.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import UIKit

class SearchPresenter {
    // MARK: - Variables
    weak var view: SearchViewProtocol?
    let interactor: SearchInteractorProtocol?
    let wireframe: SearchWireframeProtocol?
    
    private var searchs: [SearchItem] = []
    private var shouldLoadingCell = false

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
        if let searchItem = searchItem(for: row) {
            wireframe?.showMovieDetail(searchItem.id)
        } else {
            view?.displayError(Localized.errorGetItem)
        }
    }
    
    func shouldShowLoadingCell() -> Bool {
        shouldLoadingCell
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldLoadingCell,
              numberOfItems(section: indexPath.section) > 0 else {
                  return false
              }
        
        return indexPath.row == numberOfItems(section: indexPath.section)
    }
    
    func search(_ text: String) {
        interactor?.getSearchList(by: text).done({ searchItems in
            self.searchs = searchItems
            self.shouldLoadingCell = self.interactor?.shouldShowLoadingCell() ?? false
            self.view?.reloadData()
        }).catch({ error in
            self.view?.displayError(error.localizedDescription)
        })
    }
    
    func nextPage(for text: String) {
        interactor?.getNextPage(for: text).done({ searchItems in
            if !searchItems.isEmpty {
                self.shouldLoadingCell = self.interactor?.shouldShowLoadingCell() ?? false
                self.searchs += searchItems
                self.view?.reloadData()
            }
        }).catch({ error in
            self.view?.displayError(error.localizedDescription)
        })
    }
    
    func cleanSearch() {
        searchs = []
        shouldLoadingCell = false
        view?.cleanSearch()
    }
}

// MARK: - Private methods
private extension SearchPresenter {
}
