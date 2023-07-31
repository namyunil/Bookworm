//
//  BookwormCollectionViewController.swift
//  Bookworm
//
//  Created by NAM on 2023/07/31.
//

import UIKit



class BookwormCollectionViewController: UICollectionViewController {

    
    var movieList = MovieInfo()

    var colorList: [UIColor] = [.orange, .blue, .brown, .red, .green, .magenta, .systemBrown, .systemYellow, .systemIndigo, .purple, .systemMint, .quaternarySystemFill]
    
    
    
    
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
        
        let row = movieList.movie[indexPath.row]
        cell.moviePosterImage.image = UIImage(named: row.title)
        cell.movieTitleLabel.text = row.title
        cell.movieRatings.text = "\(row.rate)"
        
        //cell.backgroundView?.layer.cornerRadius = 10
        cell.movieBackView.layer.cornerRadius = 15
        cell.movieBackView.backgroundColor = colorList.shuffled()[indexPath.row]
        
        return cell
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 스토리 보드 선택
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 뷰컨트롤러 선택
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.contents = movieList.movie[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
