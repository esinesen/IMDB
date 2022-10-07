//
//  MockViewController.swift
//  IMDBAppTests
//
//  Created by Esin Esen on 4.05.2022.
//

import Foundation
import UIKit
@testable import IMDBApp

final class MockViewController: HomeViewControllerProtocol {
    
    var isInvokedReloadData = false
    var isInvokedShowLoadingView = false
    var isInvokedHideLoadingView = false
    var isInvokedSetTitle = false
    var isInvokedSetupTableView = false
    var isInvokedSetupCollectionView = false
    var isInvokedSetupSearchBar = false
    var isInvokedSetupUI = false
    var isInvokedApplyConstraints = false
    
    func reloadData() {
        self.isInvokedReloadData = true
    }
    func showLoadingView() {
        self.isInvokedShowLoadingView = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoadingView = true
    }
    
    func setTitle(_ title: String) {
        self.isInvokedSetTitle = true
    }
    
    func setupTableView() {
        self.isInvokedSetupTableView = true
    }
    
    func setupCollectionView() {
        self.isInvokedSetupCollectionView = true
    }
    
    func setupSearchBar() {
        self.isInvokedSetupSearchBar = true
    }
    
    func setupUI(isHidden: Bool) {
        self.isInvokedSetupUI = true
    }
    
    func applyConstraints(topAnchor: CGFloat) {
        self.isInvokedApplyConstraints = true
    }
}
