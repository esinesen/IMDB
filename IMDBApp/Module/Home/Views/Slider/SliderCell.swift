//
//  SliderCell.swift
//  IMDBApp
//
//  Created by Esin Esen on 27.04.2022.
//

import Foundation

import UIKit
import Kingfisher

protocol SliderCellProtocol: AnyObject {
    func setTitleLabel(_ text: String)
    func setMoviesImageView(_ imageUrl: String)
}

final class SliderCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviesImageView: UIImageView!
    
    var cellPresenter: SliderCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension SliderCell: SliderCellProtocol {
    
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

}
