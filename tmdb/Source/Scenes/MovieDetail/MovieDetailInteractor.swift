import Foundation
import PromiseKit

enum MovieDetailInteractorError: Error {
    case getMovieDetailError(String)
}

class MovieDetailInteractor {
    private let repository: MovieRepositoryProtocol!
    
    init(_ repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    func getMovieDetail(by id: String) -> Promise<Movie> {
        return Promise<Movie> { seal in
            repository.getMovieDetail(by: id).done({ json in
                if let movie = Movie(json: json) {
                    seal.fulfill(movie)
                } else {
                    seal.reject(MovieDetailInteractorError.getMovieDetailError("Unkown parse element"))
                }
            }).catch { error in
                seal.reject(MovieDetailInteractorError.getMovieDetailError(error.localizedDescription))
            }
        }
    }
}

private extension MovieDetailInteractor {
}
