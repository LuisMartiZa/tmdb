//
//  Movie.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class Movie {
    var id: String!
    var title: String!
    var voteAverage: String!
    var overview: String!
    var posterURL: String!
    var originalTitle: String?
    var adult: Bool?
    var budget: String?
    var releaseDate: String?
    var status: String?
    
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
              let voteAverage = json["vote_average"] as? Double,
              let description = json["overview"] as? String,
              let posterPath = json["poster_path"] as? String else {
                  return nil
              }
        
        self.title = title
        self.voteAverage = String(voteAverage)
        self.overview = description == "" ? Localized.noOverviewText : description
        self.posterURL = Secret.imageBase.rawValue + posterPath
        
        if let originalTitle = json["original_title"] as? String {
            self.originalTitle = originalTitle
        }
        if let adult = json["adult"] as? Bool {
            self.adult = adult
        }
        if let budget = json["budget"] as? Int {
            self.budget = String(budget)
        }
        if let releaseDate = json["releaseDate"] as? String {
            self.releaseDate = releaseDate
        }
        if let status = json["status"] as? String {
            self.status = status
        }
    }
}
