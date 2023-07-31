//
//  SearchViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/01.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        let xMark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black 
    }
    
    
    @objc func closeButtonClicked() {
        
        //Present - Dismiss
        dismiss(animated: true)
        
    }
    
}
