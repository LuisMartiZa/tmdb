//
//  SearchCollectionViewCell.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables
    static let nibName = "SearchCollectionViewCell"
    static let reuseIdenfier = "searchIdentifier"
    
    func setData(from searchItem: SearchItem) {
        let urlImage = URL(string: searchItem.posterURL)
        
        self.posterImageView.kf.setImage(with: urlImage)
        self.titleLabel.text = searchItem.title
        self.voteAverageLabel.text = searchItem.voteAverage
        self.descriptionLabel.text = searchItem.overview
    }
}
