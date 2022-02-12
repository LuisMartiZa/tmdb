//
//  SearchViewController.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var presenter: SearchPresenterProtocol?
    
    let searchController = UISearchController(searchResultsController: nil)
    var dispatchWorkItem: DispatchWorkItem? = nil
    let typeInterval: TimeInterval = 1.0
    
    var lastSearchString: String = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activateSearchController()
    }
}

// MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func displayError(_ error: String) {
        reloadData()
        //TODO: Show alert
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 3 {
            if text != lastSearchString {
                handleTyping(text)
            }
        } else {
            presenter?.cleanSearch()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(row: indexPath.row, section: indexPath.section)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.numberOfSections() ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdenfier, for: indexPath)
        
        if let presenter = presenter,
           let searchItem = presenter.searchItem(for: indexPath.row),
           let searchCell = cell as? SearchCollectionViewCell {
            searchCell.setData(from: searchItem)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat =  295
        let height: CGFloat = 90
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private methods
private extension SearchViewController {
    func setupView() {
        title = "TMDB Search Engine"
        
        setupCollectionView()
        setupSearchController()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        collectionView.register(UINib(nibName: SearchCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdenfier)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func activateSearchController() {
        searchController.isActive = true
    }
    
    func handleTyping(_ text: String) {
        dispatchWorkItem?.cancel()
        
        dispatchWorkItem = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.lastSearchString = text
            self.presenter?.search(text)
        })
        
        if let typingWorkItem = dispatchWorkItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + typeInterval, execute: typingWorkItem)
        }
    }
}
