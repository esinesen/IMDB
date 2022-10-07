//
//  IMDBAppTests.swift
//  IMDBAppTests
//
//  Created by Esin Esen on 26.04.2022.
//

import XCTest
@testable import IMDBApp

class IMDBAppTests: XCTestCase {

    var presenter: HomePresenter!
    var view: MockViewController!
    var router: MockRouter!
    var interactor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        presenter = nil
        view = nil
        router = nil
        interactor = nil
    }

    func test_viewDidLoad() {
        XCTAssertFalse(view.isInvokedShowLoadingView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedHideLoadingView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetTitle, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetupTableView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetupCollectionView, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetupSearchBar, "Your value is true, but you expected it to be false")
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedShowLoadingView, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetTitle, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetupTableView, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetupCollectionView, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetupSearchBar, "Your value is false, but you expected it to be true")
    }
    
    func test_searchTextChanged() {
        XCTAssertFalse(view.isInvokedReloadData, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedSetupUI, "Your value is true, but you expected it to be false")
        XCTAssertFalse(view.isInvokedApplyConstraints, "Your value is true, but you expected it to be false")
        
        presenter.searchTextChanged("")
        
        XCTAssertTrue(view.isInvokedReloadData, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedSetupUI, "Your value is false, but you expected it to be true")
        XCTAssertTrue(view.isInvokedApplyConstraints, "Your value is false, but you expected it to be true")
    }
    
    

    func test_fetchMovies(){
        XCTAssertNil(presenter.movie(0)?.title, "Movie title is filled")
        XCTAssertEqual(presenter.numberOfRows(), 0)
        
        presenter.fetchMoviesOutput(result: .success(MoviesResult.response))
        
        XCTAssertEqual(presenter.movie(0)?.title, "The Outfit")
        XCTAssertEqual(presenter.numberOfRows(), 20)
    }
    
    func test_fetchTopMovies(){
        XCTAssertNil(presenter.topMovie(0)?.title, "Movie title is filled")
        XCTAssertEqual(presenter.numberOfItems(), 0)
        
        presenter.fetchTopMoviesOutput(result: .success(TopMoviesResult.response))
        
        XCTAssertEqual(presenter.topMovie(0)?.title, "Uncharted")
        XCTAssertEqual(presenter.numberOfItems(), 20)
    }
}

extension MoviesResult {
    static var response: MoviesResponse {
        let bundle = Bundle(for: IMDBAppTests.self)
        let path = bundle.path(forResource: "Movies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
        return movieResponse
    }
}

extension TopMoviesResult {
    static var response: TopMoviesResponse {
        let bundle = Bundle(for: IMDBAppTests.self)
        let path = bundle.path(forResource: "TopMovies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(TopMoviesResponse.self, from: data)
        return movieResponse
    }
}
