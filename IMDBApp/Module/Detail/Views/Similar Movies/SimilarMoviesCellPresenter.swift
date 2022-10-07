//
//  SimilarMoviesCellPresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 30.04.2022.
//

import Foundation

protocol SimilarMoviesCellPresenterProtocol {
    func load()
}

final class SimilarMoviesCellPresenter {

    weak var view:SimilarMoviesCellProtocol?
    private var similar: SimilarMovie
    
    init(view:SimilarMoviesCellProtocol? , similar: SimilarMovie) {
        self.view = view
        self.similar = similar
    }
}

extension SimilarMoviesCellPresenter:SimilarMoviesCellPresenterProtocol {
    func load() {
        view?.setTitleLabel(similar.title ?? "")
        view?.setMovieImage(similar.posterPath ?? "")
    }
}

