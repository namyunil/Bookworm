//
//  SearchGlassViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/08/02.
//

import UIKit

class SearchGlassViewController: UIViewController {

    
   

    @IBOutlet var PopularMovieTableView: UITableView!
    @IBOutlet var RecentlyViewedCollectionView: UICollectionView!
    
    
    var movieList = MovieInfo()
    var recentlyList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PopularMovieTableView.dataSource = self
        PopularMovieTableView.delegate = self
        
        RecentlyViewedCollectionView.dataSource = self
        RecentlyViewedCollectionView.delegate = self
        
        
        let nib = UINib(nibName: "PopularMovieTableViewCell", bundle: nil)
        PopularMovieTableView.register(nib, forCellReuseIdentifier: "PopularMovieTableViewCell")
        
        setCollecionViewLayout()
        
        
        
    }
    
    func setCollecionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        RecentlyViewedCollectionView.collectionViewLayout = layout
    }
    
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "요즘 인기 작품"
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieList.movie.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell") as! PopularMovieTableViewCell
//
//        let row = movieList.movie[indexPath.row]
//
//        cell.moviePosterImageView.image = UIImage(named: row.title)
//        cell.movieTitleLabel.text = row.title
//        cell.movieInformationLabel.text = " \(row.releaseDate) | \(row.runtime)분 | \(row.rate)점"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recentlyList.movie.count
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyViewCollectionViewCell", for: indexPath) as! RecentlyViewCollectionViewCell
//
//        cell.recentlyViedImageView.image = UIImage(named: movieList.movie[indexPath.item].title)
//
//
//
//        return cell
//    }
    
    //** 궁금증
    //컬렉션 뷰 헤더 위치에 글자를 쓸 수 없을까?
    //테이블 뷰 섹션의 이름을 이용하지 않고 레이블을 사용하는 방법이 있을까?
    //-> 테이블 뷰 헤더에 뷰( 컬렉션 뷰 + 레이블 )을 활용하여 구현해보자..!
    
    
    //컬렉션 뷰 이미지로 할까? 버튼으로 구현할까?
    //이미지 크기가 큰 상황..!
    //버튼으로 구현 시 이미지 크기 조절이 쉽지않았음. 크게 나오는 경우가 많아 이미지뷰로 넣어 셀 선택시 상세화면으로 이동하도록 구현하자..!
    //Button content mode
    //버튼은 애니메이션 효과를 줄 때 보다 이미지뷰보다 간편하게 활용할 수 있다.
    //하지만 내부에 버튼을 구현하면 IBAction을 활용할 수 없어 addTarget과 함수를 활용하여 구현해야하는 점..!
    
    
    
    //테이블 뷰 선택시 상세화면 FullScreen Present
    //FullScreen 구현시 X버튼으로 나가야함..!
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//
//        let nav = UINavigationController(rootViewController: vc)
//
//        nav.modalPresentationStyle = .fullScreen
//
//        present(nav, animated: true)
//
//        //데이터 넘겨야함..!
//        vc.data = movieList.movie[indexPath.row]
//        vc.type = .present
//    }
    
    
    //컬렉션 뷰 선택시 상세화면 FullScreen Present
    //FullScreen 구현시 X버튼으로 나가야함..!
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//
//        let nav = UINavigationController(rootViewController: vc)
//
//        nav.modalPresentationStyle = .fullScreen
//
//        present(nav, animated:  true)
//
//        vc.data = movieList.movie[indexPath.item]
//        vc.type = .present
//    }
    
    
}

extension SearchGlassViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }
    

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell") as! PopularMovieTableViewCell
        
        let row = movieList.movie[indexPath.row]
        
        cell.moviePosterImageView.image = UIImage(named: row.title)
        cell.movieTitleLabel.text = row.title
        cell.movieInformationLabel.text = " \(row.releaseDate) | \(row.runtime)분 | \(row.rate)점"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //테이블 뷰 선택시 상세화면 FullScreen Present
    //FullScreen 구현시 X버튼으로 나가야함..!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
        //데이터 넘겨야함..!
//        vc.data = movieList.movie[indexPath.row]
        vc.type = .present
    }
    
    
    
}


extension SearchGlassViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyList.movie.count
    }
        
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyViewCollectionViewCell", for: indexPath) as! RecentlyViewCollectionViewCell
        
        cell.recentlyViedImageView.image = UIImage(named: movieList.movie[indexPath.item].title)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated:  true)

//        vc.data = movieList.movie[indexPath.item]
        vc.type = .present
    }
    
}
