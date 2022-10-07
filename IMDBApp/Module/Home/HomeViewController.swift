//
//  HomeViewController.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func setupTableView()
    func setupCollectionView()
    func setupSearchBar()
    func setupUI(isHidden: Bool)
    func applyConstraints(topAnchor: CGFloat)
}

final class HomeViewController: BaseViewController, LoadingShowable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!    
    @IBOutlet weak var topAnchor: NSLayoutConstraint!

    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: MoviesCell.self)
    }
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: SliderCell.self)
    }
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    func setupUI(isHidden: Bool) {
        collectionView.isHidden = isHidden
    }
    func applyConstraints(topAnchor: CGFloat) {
        self.topAnchor.constant = topAnchor
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MoviesCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = MoviesCellPresenter(view: cell, movie: movie)
        }
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SliderCell.self, for: indexPath)
        if let topMovie = presenter.topMovie(indexPath.row) {
            cell.cellPresenter = SliderCellPresenter(view: cell, movie: topMovie)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         presenter.searchTextChanged(searchText)
    }
}
