//
//  ServiceManager.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func fetchMovies(completionHandler: @escaping (MoviesResult) -> ())
    func fetchTopMovies(completionHandler: @escaping (TopMoviesResult) -> ())
    func fetchDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ())
    func fetchSimilar(movieId: Int, completionHandler: @escaping (SimilarMoviesResult) -> ())
    func fetchSearchResult(search: String , completionHandler: @escaping (SearchMoviesResult) -> ())
}

struct MoviesService: MoviesServiceProtocol {
    
    func fetchMovies(completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.upcoming, decodeToType: MoviesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchTopMovies(completionHandler: @escaping (TopMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: TopMoviesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.detail(movieId: movieId), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSimilar(movieId: Int, completionHandler: @escaping (SimilarMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.similar(movieId: movieId), decodeToType: SimilarMoviesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSearchResult(search: String, completionHandler: @escaping (SearchMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.search(searchText: search), decodeToType: SearchMoviesResponse.self, completionHandler: completionHandler)
    }
}
