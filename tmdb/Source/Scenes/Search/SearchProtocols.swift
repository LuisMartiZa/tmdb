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
    func displayError(_ error: String)
}

protocol SearchPresenterProtocol: AnyObject {
    func search(_ text: String)
    func cleanSearch()
    func didSelect(row: Int, section: Int)
    
    func numberOfSections() -> Int
    func numberOfItems(section: Int) -> Int
    
    func searchItem(for row: Int) -> SearchItem?
    func nextPage()
}

protocol SearchInteractorProtocol: AnyObject {
    func getSearchList(by text: String) -> Promise<[SearchItem]>
}

protocol SearchWireframeProtocol: AnyObject {
}
