//
//  BookWormAssignmentViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/10.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import RealmSwift


struct Book {
    var authors: [String]
    let title: String
    let publisher: String
    let content: String
    let image: String
    let date: String
    let price: Int
    let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    var info: String {
        
            return "저자: \(authors[0]) | 출판사: \(publisher) | 발매일: \(date)"
        
    }
}

/*
 {
 "documents": [
 {
 "authors": [
 "기시미 이치로",
 "고가 후미타케"
 ],
 "contents": "이런 그의 고민에 “인간은 변할 수 있고, 누구나 행복해 질 수 있다. 단 그러기 위해서는 ‘용기’가 필요하다”고 말한 철학자가 있다. 바로 프로이트, 융과 함께 ‘심리학의 3대 거장’으로 일컬어지고 있는 알프레드 아들러다.  『미움받을 용기』는 아들러 심리학에 관한 일본의 1인자 철학자 기시미 이치로와 베스트셀러 작가인 고가 후미타케의 저서로, 아들러의 심리학을 ‘대화체’로 쉽고 맛깔나게 정리하고 있다. 아들러 심리학을 공부한 철학자와 세상에 부정적",
 "datetime": "2014-11-17T00:00:00.000+09:00",
 "isbn": "8996991341 9788996991342",
 "price": 14900,
 "publisher": "인플루엔셜",
 "sale_price": 13410,
 "status": "정상판매",
 "thumbnail": "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038%3Ftimestamp%3D20230128141840",
 "title": "미움받을 용기",
 "translators": [
 "전경아"
 ],
 "url": "https://search.daum.net/search?w=bookpage&bookId=1467038&q=%EB%AF%B8%EC%9B%80%EB%B0%9B%EC%9D%84+%EC%9A%A9%EA%B8%B0"
 },
 */

class BookWormAssignmentViewController: UIViewController {
    
    
    @IBOutlet var bookWormTableView: UITableView!
    @IBOutlet var bookSearchBar: UISearchBar!

    var authorList: [String] = []
    var bookList: [Book] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookWormTableView.delegate = self
        bookWormTableView.dataSource = self
        bookWormTableView.prefetchDataSource = self
        
        bookSearchBar.delegate = self
        
        bookWormTableView.rowHeight = 150
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(chevronButtonClicked))
        
        
    }
    
    @objc func chevronButtonClicked() {
        dismiss(animated: true)
    }
    
    func callRequest(query: String, page: Int) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization": APIKey.kakaoAK]
        
        print(url)
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["documents"].arrayValue {
                    
                    //1. 저자가 문자열 배열로 되어있을 경우에 모든 배열의 값을 넣기위해선 어떻게 해야할까?
                    // for num in 0...autohrs.count - 1 {
                    //      let a = ""
                    //      a = a + \(authors[num])
                    
                    //1-1.array.join
                    //1-2.반복문..!
                    
                    
                    //2. dateformatter()를 활용하여 발매일을 표현해보자
               
                    self.authorList = []
                    let author = item["authors"].arrayValue
                    for item in author {
                        self.authorList.append(item.stringValue)
                    }
                    let title = item["title"].stringValue
                    let publisher = item["publisher"].stringValue
                    let content = item["contents"].stringValue
                    let image = item["thumbnail"].stringValue
                    let date = item["datetime"].stringValue
                    let price = item["price"].intValue
                    
                    let data = Book(authors: self.authorList, title: title, publisher: publisher, content: content, image: image, date: date, price: price)
                    
                    self.bookList.append(data)
                    print("===")
                    print(data)
                    
                }
                
                self.bookWormTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BookWormAssignmentViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookWormAssignmentTableViewCell") as? BookWormAssignmentTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = bookList[indexPath.row].title
        cell.infoLabel.text = bookList[indexPath.row].info
        cell.contentLabel.text = bookList[indexPath.row].content
        
        if let url = URL(string: bookList[indexPath.row].image) {
            cell.bookImageView.kf.setImage(with: url)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = bookList[indexPath.row]
        
        let realm = try! Realm()
         
        let task = BookWormTable(author: row.authors[0], title: row.title, publisher: row.publisher, price: row.price, image: row.image, content: row.content)
        
        try! realm.write {
            realm.add(task)
            print("Realm Add Succeed")
        }
        
        let value = URL(string: row.image)
        var image: UIImage?
        
        
            if let url = value, let data = try? Data(contentsOf: url ) {
                image = UIImage(data: data)
        
            
                if let image {
                    self.saveImageToDocument(fileName: "jack_\(task._id).jpg", image: image)
                }
        }
        
            
            
        
        
        dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //배열의 형태이기때문에..!
        for indexPath in indexPaths {
            
            if bookList.count - 1 == indexPath.row && page < 15 {
                page += 1
                callRequest(query: bookSearchBar.text!, page: page)
            }
        }
        
    }
    
    
}

extension BookWormAssignmentViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //tableViewpreFetch로 인해 이전의 검색 페이지에 해당하는 페이지의 검색결과가 나오게 된다. 검색할때 마다 1페이지를 가장 상단에 위치시키기 위해선 페이지에 1을 할당해주어야 한다.
        page = 1
        
        //새로운 검색 리스트가 가장 위에 나오도록 이전의 검색 기록을 매 검색시마다 지워준다.
        bookList.removeAll()
        
        guard let query = bookSearchBar.text else { return }
        callRequest(query: query, page: page)
        
        view.endEditing(true)
    }
}
