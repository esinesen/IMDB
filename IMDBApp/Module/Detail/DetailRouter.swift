//
//  DetailRouter.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case detail(movie : MovieDetailResponse)
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule() ->  DetailViewController {
        let provider = UserDataProvider()
        let view =  DetailViewController(provider:provider)
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor , provider: provider)
        view.presenter = presenter
        interactor.output = presenter 
        router.viewController = view
       
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = DetailRouter.createModule()
            detailVC.detail = movie
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}



   
    
    

