//
//  SearchItem.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

class SearchItem {
    var id: String!
    var title: String!
    var voteAverage: String!
    var overview: String!
    var posterURL: String!
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let title = json["title"] as? String,
              let voteAverage = json["vote_average"] as? Double,
              let description = json["overview"] as? String,
              let posterPath = json["poster_path"] as? String else {
                  return nil
              }
        
        self.id = String(id)
        self.title = title
        self.voteAverage = String(voteAverage)
        self.overview = description == "" ? "No overview" : description
        self.posterURL = Secret.imageBase.rawValue + posterPath
    }
}
