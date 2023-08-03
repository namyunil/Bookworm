//
//  BookwormCollectionViewCell.swift
//  Bookworm
//
//  Created by NAM on 2023/07/31.
//

import UIKit


class BookwormCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var movieBackView: UIView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var moviePosterImage: UIImageView!
    @IBOutlet var movieRatings: UILabel!
    @IBOutlet var movieLikeButton: UIButton!
    
    
    
    func configureCell(row: Movie) {
       
        movieBackView.backgroundColor = row.color
        moviePosterImage.image = UIImage(named: row.title)
        movieTitleLabel.text = row.title
        movieRatings.text = "\(row.rate)"
        movieBackView.layer.cornerRadius = 15
        
        
        if row.like {
            movieLikeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            movieLikeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    
    
}
