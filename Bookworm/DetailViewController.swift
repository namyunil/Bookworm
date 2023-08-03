//
//  DetailViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/01.
//

import UIKit

enum TransitionType {
    case push
    case present
}

class DetailViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var movieInformationLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    
    
    
    
    
    
    //@IBAction처럼 함수 하나 만들기..!
    //이전 화면이 많은 정보를 갖고있기 때문에 새로운 화면에서는 "나 사라질게~"만 설정해주면 된다..!
    // present - dismiss / push - pop으로 알맞게 설정해주어야 정상적으로 사라진다..!
    
    //var push: Bool = true
    var type: TransitionType = .push
    
    //1. 값 담을 공간
    
    var data: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data else { return }
        
        titleLabel.text = data.title
        posterImageView.image = UIImage(named: data.title)
        overviewLabel.text = data.overview
        movieInformationLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        
        //        if push == false {
        //            let xMark = UIImage(systemName: "xmark")
        //
        //            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonClicked))
        //            navigationItem.leftBarButtonItem?.tintColor = .black
        //
        //        } else {
        //            navigationItem.titleView?.isHidden = true
        //
        //        }
        
        
        switch type {
        case .push:
//            navigationItem.titleView?.isHidden = true
            return
        case .present:
            let xMark = UIImage(systemName: "xmark")
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .black
            
        }
        
        
    }
    
    @objc // 빌드 시 objc로 알아서 변환해준다..!
    func closeButtonClicked() {
        
        //Present - Dismiss
        dismiss(animated: true)
    }
}
