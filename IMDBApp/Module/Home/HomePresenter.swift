//
//  HomePresenter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func movie(_ index: Int) -> Movie?
    func topMovie(_ index: Int) -> Movie?
    func numberOfRows() -> Int
    func didSelectRowAt(index: Int)
    func numberOfItems() -> Int
    func didSelectItemAt(index: Int)
    func searchTextChanged(_ text:String)
}

final class HomePresenter: HomePresenterProtocol {

    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var movies: [Movie] = []
    private var topMovies: [Movie] = []
    private var searchMovies: [Movie] = []
    
    var isFiltering: Bool = false
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupCollectionView()
        view?.setTitle("Home")
        view?.setupSearchBar()
        fetchMovies()
    }
    
    func movie(_ index: Int) -> Movie? {
        if isFiltering == true {
            return searchMovies[safe: index]
        } else {
            return movies[safe: index]
        }
    }
    
    func topMovie(_ index: Int) -> Movie? {
        return topMovies[safe: index]
    }
    
    func numberOfRows() -> Int {
        if isFiltering == true {
            return searchMovies.count
        } else {
            return movies.count
        }
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        interactor.fetchMovieDetail(movieId: movie.id ?? 0)
     
    }
    
    func numberOfItems() -> Int {
        return topMovies.count
    }
    
    func didSelectItemAt(index: Int) {
        guard let topMovie = topMovie(index) else { return }
        interactor.fetchMovieDetail(movieId: topMovie.id ?? 0)
    }
    
    func searchTextChanged(_ text: String) {
        if text.count < 2 {
            if text.isEmpty == true{
                view?.reloadData()
                isFiltering = false
                view?.setupUI(isHidden: false)
                view?.applyConstraints(topAnchor: 200)
            }
            return
        } else {
            isFiltering = true
            view?.setupUI(isHidden: true)
            view?.applyConstraints(topAnchor: 50)
            interactor.fetchSearchResult(searchText: text)
        }
    }
    
    private func fetchMovies() {
        view?.showLoadingView()
        interactor.fetchMovies()
        interactor.fetchTopMovies()
    }
}

extension HomePresenter : HomeInteractorOutputProtocol {
    
    func fetchMoviesOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            movies = moviesResult.results ?? []
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchTopMoviesOutput(result: TopMoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let topMoviesResult):
            topMovies = topMoviesResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchDetailOutput(result: MovieDetailResult) {
        switch result {
        case .success(let movieDetailResult):
            router.navigate(.detail(movie: movieDetailResult))
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSearchResultOutput(result: SearchMoviesResult) {
        switch result {
        case .success(let searchResult):
            searchMovies = searchResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}
