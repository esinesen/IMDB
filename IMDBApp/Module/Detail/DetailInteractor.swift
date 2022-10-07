//
//  DetailInteractor.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func fetchSimilar(movieId: Int)
    func fetchSimilarDetail(movieId: Int)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func fetchSimilarOutput(result: SimilarMoviesResult)
    func fetchSimilarDetailOutput(result: MovieDetailResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse,Error>
typealias SimilarMoviesResult = Result<SimilarMoviesResponse,Error>


fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func fetchSimilar(movieId: Int) {
        moviesService.fetchSimilar(movieId: movieId) { [weak self] result in guard let self = self else { return }
            self.output?.fetchSimilarOutput(result:result)
        }
    }
    
    func fetchSimilarDetail(movieId: Int) {
        moviesService.fetchDetail(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarDetailOutput(result:result)
        }
    }
}
