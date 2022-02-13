//
//  LoadingCollectionViewCell.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    static let nibName = "LoadingCollectionViewCell"
    static let reuseIdenfier = "loadingIdentifier"
}
