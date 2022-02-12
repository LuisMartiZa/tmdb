//
//  MovieDetailPresenter.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class MovieDetailPresenter {

    weak var view: MovieDetailViewProtocol?
    let interactor: MovieDetailInteractorProtocol?
    let wireframe: MovieDetailWireframeProtocol?
    
    var movieID: String!
    var movie: Movie!

    init(view: MovieDetailViewProtocol?,
         interactor: MovieDetailInteractorProtocol?,
         wireframe: MovieDetailWireframeProtocol?) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func viewDidLoad() {
        // Make request to get info from endpoint
        interactor?.getMovieDetail(by: movieID).done({ movie in
            self.movie = movie
            self.view?.refreshData()
        }).catch({ error in
            self.view?.displayError(error.localizedDescription)
        })
    }
    
    func getPosterURL() -> URL {
        URL(string: movie.posterURL)!
    }
    
    func getTitle() -> String {
        movie.title
    }
    
    func getVoteAverage() -> String {
        movie.voteAverage
    }
    
    func getOverview() -> String {
        movie.overview
    }
}

private extension MovieDetailPresenter {
}
