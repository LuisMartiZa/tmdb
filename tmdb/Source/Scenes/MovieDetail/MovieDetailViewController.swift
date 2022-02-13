//
//  MovieDetailViewController.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

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
        setupView()
        presenter?.viewDidLoad()
    }
}

// MARK: - MovieDetailViewProtocol
extension MovieDetailViewController: MovieDetailViewProtocol {
    func refreshData() {
        posterImageView.kf.setImage(with: presenter?.getPosterURL())
        titleLabel.text = presenter?.getTitle()
        voteAverageLabel.text = presenter?.getVoteAverage()
        overviewTextView.text = presenter?.getOverview()
    }
    
    func displayError(_ error: String) {
        showAlert(title: Localized.errorTitle, body: error) {
            self.presenter?.dismissView()
        }
    }
}

// MARK: - Private methods
private extension MovieDetailViewController {
    func setupView() {
        overviewTextView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
