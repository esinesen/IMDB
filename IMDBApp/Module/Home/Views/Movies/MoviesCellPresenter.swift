//
//  MoviesCellPresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol MoviesCellPresenterProtocol: AnyObject {
    func load()
}

final class MoviesCellPresenter {
    
    weak var view: MoviesCellProtocol?
    private let movie: Movie
    
    init(view: MoviesCellProtocol?, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

extension MoviesCellPresenter: MoviesCellPresenterProtocol {
    
    func load() {
        view?.setTitleLabel(movie.title ?? "")
        view?.setMoviesImageView(movie.posterPath ?? "")
        view?.setDateLabel(movie.releaseDate ?? "")
        view?.setVoteLabel(movie.voteAverage ?? 0)
    }
}
