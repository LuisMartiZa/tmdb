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
    
    func cleanSearch() {
        lastSearchString = ""
        reloadData()
    }
    
    func displayError(_ error: String) {
        reloadData()
        
        showAlert(title: Localized.errorTitle, body: error)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let presenter = presenter,
              presenter.isLoadingIndexPath(indexPath) else {
                  return
              }
        
        presenter.nextPage(for: lastSearchString)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.numberOfSections() ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        let numberOfItems = presenter.numberOfItems(section: section)
        return presenter.shouldShowLoadingCell() ? numberOfItems + 1 : numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }
        
        if presenter.isLoadingIndexPath(indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.reuseIdenfier, for: indexPath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdenfier, for: indexPath)
            
            if let searchItem = presenter.searchItem(for: indexPath.row),
               let searchCell = cell as? SearchCollectionViewCell {
                searchCell.setData(from: searchItem)
            }
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        var height: CGFloat = 200
        if let isLoadingCell = presenter?.isLoadingIndexPath(indexPath),
           isLoadingCell {
            height = 100
        }
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private methods
private extension SearchViewController {
    func setupView() {
        title = Localized.searchTitle
        
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
        collectionView.register(UINib(nibName: LoadingCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: LoadingCollectionViewCell.reuseIdenfier)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localized.searchControllerPlaceholder
        
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
