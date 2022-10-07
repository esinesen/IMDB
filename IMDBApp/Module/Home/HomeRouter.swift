//
//  HomeRouter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(movie : MovieDetailResponse)
}

final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = DetailRouter.createModule()
            detailVC.detail = movie
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
