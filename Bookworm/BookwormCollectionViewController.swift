//
//  BookwormCollectionViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/07/31.
//

import UIKit



class BookwormCollectionViewController: UICollectionViewController {
    
    
    var movieList = MovieInfo()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookwormCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookwormCollectionViewCell")
        
        SetCollectionViewlayOut()
        
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
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        //스토리 보드 선택
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //뷰컨트롤러 선택
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
        
        
        
    }
    
    
    // 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    //셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookwormCollectionViewCell", for: indexPath) as! BookwormCollectionViewCell
        
        
//        cell.moviePosterImage.image = UIImage(named: row.title)
//        cell.movieTitleLabel.text = row.title
//        cell.movieRatings.text = "\(row.rate)"
        
        //cell.backgroundView?.layer.cornerRadius = 10// 이 코드로하면 cornerRadius 적용 X
//        cell.movieBackView.layer.cornerRadius = 15 // 두 코드의 차이점에 대해 생각해보자..!
        
        
        let row = movieList.movie[indexPath.row]
        cell.configureCell(row: row)
//        cell.movieBackView.backgroundColor = colorList.shuffled()[indexPath.row]
//
//        cell.movieBackView.backgroundColor = colorList.randomElement()
        
        cell.movieLikeButton.tag = indexPath.row
        cell.movieLikeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        
        return cell
    }
    
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        print("clicked \(sender.tag)")
        movieList.movie[sender.tag].like.toggle()
        collectionView.reloadData()
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 스토리 보드 선택
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 뷰컨트롤러 선택
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let row = movieList.movie[indexPath.row]
        
        vc.data = row
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
