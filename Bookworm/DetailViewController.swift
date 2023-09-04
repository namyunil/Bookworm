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
  
  
    
    @IBOutlet var overviewTableView: UITableView!
    
    @IBOutlet var contentTextView: UITextView!
    
    
    let placeholderText = "내용을 입력해주세요"
    
    //@IBAction처럼 함수 하나 만들기..!
    //이전 화면이 많은 정보를 갖고있기 때문에 새로운 화면에서는 "나 사라질게~"만 설정해주면 된다..!
    // present - dismiss / push - pop으로 알맞게 설정해주어야 정상적으로 사라진다..!
    
    //var push: Bool = true
    var type: TransitionType = .push
    
    //1. 값 담을 공간
    
    var data: Movie?
    var realmData: BookWormTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTableView.delegate = self
        overviewTableView.dataSource = self
        
        contentTextView.delegate = self
        
        contentTextView.text = placeholderText
        contentTextView.textColor = .lightGray
        
        
        guard let data else { return }
        
    
        titleLabel.text = data.title
        posterImageView.image = UIImage(named: data.title)
        
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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewTableViewCell") as! overviewTableViewCell
        
        if let data {
            cell.overviewLabel.text = data.overview
        }
        
        
        return cell
    }
    
}


extension DetailViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)글자"
    }
   
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
   
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
}
