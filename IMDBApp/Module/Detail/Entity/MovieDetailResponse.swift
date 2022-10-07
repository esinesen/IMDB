//
//  MovieDetailResponse.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

struct MovieDetailResponse: Codable {
    let backdropPath: String?
    let imdbID, title, overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    var favoritesStatus: Bool = false
    var id: Int
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case imdbID = "imdb_id"
        case title
        case overview
        case id
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

