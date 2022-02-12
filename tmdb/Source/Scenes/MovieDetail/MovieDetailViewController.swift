import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    // MARK: - Variables
    var presenter: MovieDetailPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - MovieDetailViewProtocol
extension MovieDetailViewController: MovieDetailViewProtocol {
    func setupView() {
        posterImageView.kf.setImage(with: presenter?.getPosterURL())
        titleLabel.text = presenter?.getTitle()
        voteAverageLabel.text = presenter?.getVoteAverage()
        overviewTextView.text = presenter?.getOverview()
    }
    
    func displayError(_ error: String) {
        
    }
    
}

// MARK: - Private methods
private extension MovieDetailViewController {
}
