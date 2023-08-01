//
//  DetailViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var movieInformationLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    //1. 값 담을 공간
    var movieTitle: String = " "
    var movieReleaseDate: String = " "
    var movieRatings: Double = 0
    var movieRuntime: Int = 0
    var posterImage: String = " "
    var movieOverview: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleLabel.text = movieTitle
        posterImageView.image = UIImage(named: movieTitle)
        overviewLabel.text = movieOverview
        movieInformationLabel.text = "\(movieReleaseDate) | \(movieRuntime)분 | \(movieRatings)점"
        
    }
    

}
