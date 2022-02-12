//
//  SearchProtocols.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import PromiseKit

protocol SearchViewProtocol: AnyObject {
    func reloadData()
    func cleanSearch()
    func displayError(_ error: String)
}

protocol SearchPresenterProtocol: AnyObject {
    func search(_ text: String)
    func cleanSearch()
    func didSelect(row: Int, section: Int)
    func shouldShowLoadingCell() -> Bool
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool
    
    func numberOfSections() -> Int
    func numberOfItems(section: Int) -> Int
    
    func searchItem(for row: Int) -> SearchItem?
    func nextPage(for text: String)
}

protocol SearchInteractorProtocol: AnyObject {
    func getSearchList(by text: String) -> Promise<[SearchItem]>
    func getNextPage(for text: String) -> Promise<[SearchItem]>
    
    func shouldShowLoadingCell() -> Bool
}

protocol SearchWireframeProtocol: AnyObject {
    func showMovieDetail(_ movieID: String)
}
