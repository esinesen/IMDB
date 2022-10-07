//
//  MockRouter.swift
//  IMDBAppTests
//
//  Created by Esin Esen on 4.05.2022.
//

import Foundation
@testable import IMDBApp

final class MockRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    
    func navigate(_ route: HomeRoutes) {
        isInvokedNavigate = true
    }
}
