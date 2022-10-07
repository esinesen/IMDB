//
//  DetailViewController.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupTableView()
    func setupCollectionView()
}

final class DetailViewController: BaseViewController , LoadingShowable{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var provider:UserDataProvider!
    var presenter: DetailPresenterProtocol!
    var detail:MovieDetailResponse?
  
    init(provider:UserDataProvider) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.fetchSimilar(detail?.id ?? 0)
    }
}

extension DetailViewController:DetailViewControllerProtocol {
   
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
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(cellType: DetailCell.self)
    }
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: SimilarMoviesCell.self)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: DetailCell.self , for:indexPath)
        cell.cellPresenter = DetailCellPresenter.init(view: cell, detail: detail!, provider: provider)
    
        return cell
    }
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SimilarMoviesCell.self, for: indexPath)
        
        cell.cellPresenter = SimilarMoviesCellPresenter(view: cell, similar:presenter.similarMovie(indexPath.row)!)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}
