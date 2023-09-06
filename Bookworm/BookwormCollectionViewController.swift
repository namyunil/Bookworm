//
//  BookwormCollectionViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/07/31.
//

import UIKit
import RealmSwift
import Kingfisher

class BookwormCollectionViewController: UICollectionViewController {
    
    
    var movieList = MovieInfo()
    
    let searchBar = UISearchBar()
    
    //영화 제목 리스트 및 담을 리스트 만들기
    
    
    var list: [Movie] = []

    var tasks: Results<BookWormTable>?
    
    let repository = BookWormRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookwormCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookwormCollectionViewCell")
        
        SetCollectionViewlayOut()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요."
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        
         
//        let realm = try! Realm()
//        tasks = realm.objects(BookWormTable.self)
        tasks = repository.fetch()
        repository.checkSchemaVersion()
        print(tasks)
//        print(realm.configuration.fileURL)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
//        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        collectionView.reloadData()
    }
    
    func SetCollectionViewlayOut() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
    }
    
    func randomBackgroundColor() -> UIColor {
        
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        //스토리 보드 선택
        let sb = UIStoryboard(name: "Assignment", bundle: nil)
        //뷰컨트롤러 선택
        let vc = sb.instantiateViewController(withIdentifier: "BookWormAssignmentViewController") as! BookWormAssignmentViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
        
        
        
    }
    
    
    // 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movieList.movie.count
        //return list.count
        guard let tasks else { return 0 }
        return tasks.count
    }
    
    //셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookwormCollectionViewCell", for: indexPath) as! BookwormCollectionViewCell
        
        
//        cell.moviePosterImage.image = UIImage(named: row.title)
//        cell.movieTitleLabel.text = row.title
//        cell.movieRatings.text = "\(row.rate)"
        
        //cell.backgroundView?.layer.cornerRadius = 10// 이 코드로하면 cornerRadius 적용 X
//        cell.movieBackView.layer.cornerRadius = 15 // 두 코드의 차이점에 대해 생각해보자..!
        
        
//        let row = movieList.movie[indexPath.row]
//        cell.configureCell(row: list[indexPath.row])
        
        guard let tasks else { return UICollectionViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.movieBackView.backgroundColor = randomBackgroundColor()
//        cell.moviePosterImage.kf.setImage(with: URL(string: row.image))
        cell.movieTitleLabel.text = row.title
        cell.movieTitleLabel.numberOfLines = 0
        cell.movieRatings.text = "\(row.memoTest)"
        cell.movieBackView.layer.cornerRadius = 15
        
//        let value = URL(string: row.image)
//
//        DispatchQueue.global().async {
//            if let url = value, let data = try? Data(contentsOf: url ) {
//
//                DispatchQueue.main.async {
//                    cell.moviePosterImage.image = UIImage(data: data)
//                }
//            }
//        }
        print("==main2==")
            cell.moviePosterImage.image = self.loadImageFromDocument(fileName: "jack_\(row._id).jpg")
        
        
        //like값 변화에 따른 UI변화 구현 X,  Transiaction..
        if row.likeTest {
            cell.movieLikeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.movieLikeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }

        
        cell.movieLikeButton.tag = indexPath.row
        cell.movieLikeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        
        return cell
    }
    
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        print("clicked \(sender.tag)")
//        movieList.movie[sender.tag].like.toggle()
        guard let tasks else { return }
        tasks[sender.tag].likeTest.toggle()
        collectionView.reloadData()
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 스토리 보드 선택
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 뷰컨트롤러 선택
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
//        let row = movieList.movie[indexPath.row]
        
//        vc.data = row
//        vc.data = list[indexPath.row]
        
        //셀 선택 시 realm으로 read한 데이터를 기반으로 디테일 뷰 구현하기..!
        guard let tasks else { return }
        vc.realmData = tasks[indexPath.row]
        vc.type = .push
        
        
//        vc.movieTitle = row.title
//        vc.posterImage = row.title
//        vc.movieRuntime = row.runtime
//        vc.movieRatings = row.rate
//        vc.movieReleaseDate = row.releaseDate
//        vc.movieOverview = row.overview
      
     
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}


extension BookwormCollectionViewController: UISearchBarDelegate {
 
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        for item in movieList.movie {
            if item.title.contains(searchBar.text!) {
                list.append(item)
//                print(list)
            }
        }
        
        collectionView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
    
    }
    //실시간 검색
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        for item in movieList.movie {
//            if item.title.contains(searchBar.text!) {
//                list.append(item)
////                print(list)
//            }
//        }
//
//        collectionView.reloadData()
//
//    }
    
}
