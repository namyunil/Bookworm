//
//  DetailViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {

    var contents: String = "값이 없음"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(contents)
        //네비게이션 컨트롤러 제목 영역에 값 전달
       title = contents
        
    }
    

}
