//
//  MockInteractor.swift
//  IMDBAppTests
//
//  Created by Esin Esen on 4.05.2022.
//

import Foundation
@testable import IMDBApp

final class MockInteractor: HomeInteractorProtocol {
    
    var invokedFetchMovies = false
    var invokedFetchMoviesCount = 0
    
    var invokedFetchTopMovies = false
    var invokedFetchTopMoviesCount = 0
    
    var invokedFetchMovieDetail = false
    var invokedFetchMovieDetailCount = 0
    
    var invokedFetchSearchResult = false
    var invokedFetchSearchResultCount = 0
    
    func fetchMovies() {
        self.invokedFetchMovies = true
        self.invokedFetchMoviesCount += 1
    }
    
    func fetchTopMovies() {
        self.invokedFetchTopMovies = true
        self.invokedFetchTopMoviesCount += 1
    }
    
    func fetchMovieDetail(movieId: Int) {
        self.invokedFetchMovieDetail = true
        self.invokedFetchMovieDetailCount += 1
    }
    
    func fetchSearchResult(searchText: String) {
        self.invokedFetchSearchResult = true
        self.invokedFetchSearchResultCount += 1
    }
}
