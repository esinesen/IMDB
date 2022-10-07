//
//  HomeInteractor.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchMovies()
    func fetchTopMovies()
    func fetchMovieDetail(movieId: Int)
    func fetchSearchResult(searchText: String)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchMoviesOutput(result: MoviesResult)
    func fetchTopMoviesOutput(result: TopMoviesResult)
    func fetchDetailOutput(result: MovieDetailResult)
    func fetchSearchResultOutput(result:SearchMoviesResult)
}

typealias MoviesResult = Result<MoviesResponse, Error>
typealias TopMoviesResult = Result<TopMoviesResponse, Error>
typealias SearchMoviesResult = Result<SearchMoviesResponse,Error>

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMovies() {
        moviesService.fetchMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMoviesOutput(result: result)
        }
    }
    
    func fetchTopMovies() {
        moviesService.fetchTopMovies{ [weak self] result in
            guard let self = self else { return }
            self.output?.fetchTopMoviesOutput(result: result)
        }
    }
    func fetchMovieDetail(movieId: Int) {
        moviesService.fetchDetail(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchDetailOutput(result:result)
        }
    }
    func fetchSearchResult(searchText: String) {
        moviesService.fetchSearchResult(search: searchText) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSearchResultOutput(result:result)
        }
    }
}
