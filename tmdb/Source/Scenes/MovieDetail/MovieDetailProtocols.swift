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
}

protocol MovieDetailInteractorProtocol: AnyObject {
    func getMovieDetail(by id: String) -> Promise<Movie>
}

protocol MovieDetailWireframeProtocol: AnyObject {
}
