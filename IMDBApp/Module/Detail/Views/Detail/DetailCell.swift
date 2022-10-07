//
//  DetailCell.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import UIKit
import Kingfisher

protocol DetailCellProtocol: AnyObject {
    func setMovieImage(_ imageUrl:String)
    func setTitleLabel(_ title:String)
    func setDetailLabel(_ text:String)
    func setDateLabel(_ text:String)
    func setVoteLabel(_ text:Double)
    func favoriteButtonSetup()
}

class DetailCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var cellPresenter:DetailCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        cellPresenter.buttonClicked(movie: cellPresenter.movieSender())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension DetailCell: DetailCellProtocol {
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
    
    func setDetailLabel(_ text: String) {
        self.detailLabel.text = text
    }
    
    func setDateLabel(_ text:String) {
        self.dateLabel.text = text
    }
    func setVoteLabel(_ text:Double) {
        self.voteLabel.text = "\(String(text)) / 10"
    }
    
    func favoriteButtonSetup(){
        if cellPresenter?.checkFavoriteStatus(movie: cellPresenter.movieSender().id) == true {
            favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
             
        }
    }
}
