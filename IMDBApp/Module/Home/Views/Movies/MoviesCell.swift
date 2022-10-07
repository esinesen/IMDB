//
//  MoviesCell.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import UIKit
import Kingfisher

protocol MoviesCellProtocol: AnyObject {
    func setTitleLabel(_ text: String)
    func setMoviesImageView(_ imageUrl: String)
    func setDateLabel(_ text:String)
    func setVoteLabel(_ text:Double)
}

final class MoviesCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviesImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    var cellPresenter: MoviesCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MoviesCell: MoviesCellProtocol {
    
    func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
    }
    
    func setMoviesImageView(_ imageUrl: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(imageUrl)")
        moviesImageView.kf.indicatorType = .activity
        moviesImageView.kf.setImage(with: url) { result in
            
            switch result {
                
            case .success(_):
                break
            case .failure(_):
                self.moviesImageView.image = UIImage(named: "error")
            }
        }
    }
    
    func setDateLabel(_ text:String) {
        self.dateLabel.text = text
    }
    
    func setVoteLabel(_ text:Double) {
        self.voteLabel.text = "\(String(text)) / 10"
    }
}
