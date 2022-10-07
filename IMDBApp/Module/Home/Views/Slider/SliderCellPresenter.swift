//
//  SliderCellPresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 27.04.2022.
//

import Foundation

protocol SliderCellPresenterProtocol: AnyObject {
    func load()
}

final class SliderCellPresenter {
    
    weak var view: SliderCellProtocol?
    private let topMovie: Movie
    
    init(view: SliderCellProtocol?, movie: Movie) {
        self.view = view
        self.topMovie = movie
    }
}

extension SliderCellPresenter: SliderCellPresenterProtocol {
    
    func load() {
        view?.setTitleLabel(topMovie.title ?? "")
        view?.setMoviesImageView(topMovie.posterPath ?? "")
    }
}
