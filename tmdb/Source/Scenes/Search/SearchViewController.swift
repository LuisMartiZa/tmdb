//
//  SearchViewController.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit

class SearchViewController: UIViewController {

    var presenter: SearchPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SearchViewController: SearchViewProtocol {
}

private extension SearchViewController {
}
