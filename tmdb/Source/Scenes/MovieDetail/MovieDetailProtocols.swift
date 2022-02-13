//
//  MovieDetailProtocols.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation
import PromiseKit

protocol MovieDetailViewProtocol: AnyObject {
    func refreshData()
    func displayError(_ error: String)
}

protocol MovieDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getPosterURL() -> URL
    func getTitle() -> String
    func getVoteAverage() -> String
    func getOverview() -> String
    
    func dismissView()
}

protocol MovieDetailInteractorProtocol: AnyObject {
    func getMovieDetail(by id: String) -> Promise<Movie>
}

protocol MovieDetailWireframeProtocol: AnyObject {
    func dismissView()
}
