//
//  TopMoviesResponse.swift
//  IMDBApp
//
//  Created by Esin Esen on 28.04.2022.
//

import Foundation

struct TopMoviesResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page,results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
