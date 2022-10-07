//
//  SearchMoviesResponse.swift
//  IMDBApp
//
//  Created by Esin Esen on 2.05.2022.
//

import Foundation

struct SearchMoviesResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
     
    enum CodingKeys: String, CodingKey {
        case page,results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
