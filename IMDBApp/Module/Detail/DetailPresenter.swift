//
//  DetailPresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func similarMovie(_ index: Int) -> SimilarMovie?
    func numberOfRows() -> Int
    func numberOfItems() -> Int
    func didSelectItemAt(index: Int)
    func fetchSimilar(_ id:Int)
}

final class DetailPresenter: DetailPresenterProtocol{
    
    private var similarMovies: [SimilarMovie] = []
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    let provider:UserDataProvider!
    
    init(view: DetailViewControllerProtocol , router : DetailRouterProtocol, interactor: DetailInteractorProtocol, provider:UserDataProvider) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.provider = provider
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupCollectionView()
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func similarMovie(_ index: Int) -> SimilarMovie? {
         return similarMovies[safe: index]
    }
    
    func numberOfItems() -> Int {
        return similarMovies.count
    }
    
    func didSelectItemAt(index: Int) {
        guard let similarMovie = similarMovie(index) else { return }
        interactor.fetchSimilarDetail(movieId: similarMovie.id ?? 0)
    }
    
    func fetchSimilar(_ id: Int) {
        interactor.fetchSimilar(movieId: id)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchSimilarOutput(result: SimilarMoviesResult) {
        switch result {
        case .success(let similarMovie):
            similarMovies = similarMovie.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSimilarDetailOutput(result: MovieDetailResult) {
        switch result {
        case .success(let similarMovieDetailResult):
            router.navigate(.detail(movie: similarMovieDetailResult))
        case .failure(let error):
            print(error)
        }
    }
}
