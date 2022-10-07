//
//  SimilarMoviesCell.swift
//  IMDBApp
//
//  Created by Esin Esen on 30.04.2022.
//

import UIKit
import Kingfisher

protocol SimilarMoviesCellProtocol: AnyObject {
    func setMovieImage(_ imageUrl:String)
    func setTitleLabel(_ title:String)
}

class SimilarMoviesCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellPresenter:SimilarMoviesCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SimilarMoviesCell: SimilarMoviesCellProtocol {
    func setMovieImage(_ imageUrl: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(imageUrl)")
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: url) { result in
        switch result {
            case .success(_):
                break
            case .failure(_):
                self.movieImage.image = UIImage(named: "error")
            }
        }
    }

    func setTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
}
