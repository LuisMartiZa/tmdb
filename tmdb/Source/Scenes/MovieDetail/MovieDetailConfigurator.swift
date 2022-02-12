import UIKit

class MovieDetailConfigurator {

    class func configureMovieDetailScene(movieID: String) -> MovieDetailViewController {

        let viewController = MovieDetailViewController()
        let repository = MovieRepository()
        let interactor = MovieDetailInteractor(repository)
        let wireframe = MovieDetailWireframe()
        let presenter = MovieDetailPresenter(view: viewController,
                                                          interactor: interactor,
                                                          wireframe: wireframe)
        presenter.movieID = movieID
        
        viewController.presenter = presenter
        wireframe.viewController = viewController
        return viewController
    }
}
