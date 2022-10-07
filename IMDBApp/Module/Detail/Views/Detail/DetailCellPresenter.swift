//
//  DetailCellPresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol DetailCellPresenterProtocol {
    func load()
    func buttonClicked(movie:MovieDetailResponse)
    func movieSender() -> MovieDetailResponse
    func checkFavoriteStatus(movie: Int) -> Bool
}

final class DetailCellPresenter {

    weak var view:DetailCellProtocol?
    var detail: MovieDetailResponse
    private var provider:UserDataProvider
    
    init(view:DetailCellProtocol? , detail: MovieDetailResponse, provider:UserDataProvider) {
        self.view = view
        self.detail = detail
        self.provider = provider
    }
    
    private func addCardToFavorites(card: MovieDetailResponse) {
        provider.addMovieToFavorites(movie: card)
    }

    private func removeCardFromFavorites(card: MovieDetailResponse) {
        provider.removeMovieFromFavorites(movie: card)
    }
}

extension DetailCellPresenter:DetailCellPresenterProtocol {
    
    func movieSender() -> (MovieDetailResponse) {
        return detail
    }
    
    func buttonClicked(movie: MovieDetailResponse){
        if provider.isFavorite(movieId: movie.id) == true {
            removeCardFromFavorites(card: movie)
            view?.favoriteButtonSetup()
        }else{
            addCardToFavorites(card: movie)
            view?.favoriteButtonSetup()
        }
    }
    
    func checkFavoriteStatus(movie: Int) -> Bool {
        if provider.isFavorite(movieId: movie) == true {
            return true
        }else{
            return false
        }
    }
    
    func load() {
        view?.setTitleLabel(detail.title ?? "")
        view?.setDetailLabel(detail.overview ?? "")
        view?.setMovieImage(detail.backdropPath ?? "")
        view?.setDateLabel(detail.releaseDate ?? "")
        view?.setVoteLabel(detail.voteAverage ?? 0)
        view?.favoriteButtonSetup()
    }
}
