//
//  ViewController.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit

class ViewController: BaseVC {
    
   // private var searchBar: UISearchBar!
    var collectionview : UICollectionView!
    
    let viewModel = ViewModel()
    var arr_movies = [Movie]()
    var arr_filtered_movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        title = Constants.MovieFlix
        self.navigationController?.hidesBarsOnSwipe = false
        
        setUpUI()
      
        self.showIndicator()
        viewModel.get_Movies {[weak self] result in
            
            self?.arr_movies = result ??  [Movie]()
            self?.arr_filtered_movies =  self?.arr_movies ??  [Movie]()

            DispatchQueue.main.async {
                self?.hideIndicator()
                self?.collectionview.reloadData()
            }
            
        } errorCompletion: { error in
            AlertManager.shared.showAlert(title: error, message: "", viewController: self)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
    }

    private func setUpUI() {
        
        // Set up search bar
        /*
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0))
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
         */
     
        
        let layout = UICollectionViewFlowLayout()
        // Set desired cell size and other layout options
      
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 150)
        
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = UIColor.white
        collectionview.register(PopularCell.self, forCellWithReuseIdentifier: Constants.Cell.PopularCell)
        collectionview.register(UnPopularCell.self, forCellWithReuseIdentifier: Constants.Cell.UnPopularCell)
  
        
        collectionview.contentInset = .zero
        collectionview.scrollIndicatorInsets = .zero

        view.addSubview(collectionview)
        
       
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: view.topAnchor ),
            collectionview.leadingAnchor.constraint(equalTo:  view.leadingAnchor),
            collectionview.trailingAnchor.constraint(equalTo:  view.trailingAnchor),
            collectionview.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
        ])
    }
}

// MARK: - collection view datasource and delegates

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.arr_movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !arr_movies.isEmpty{
            let obj_individual_movie = arr_movies[indexPath.row]
            if obj_individual_movie.voteAverage > 7 {
                let cell = collectionview.dequeueReusableCell(withReuseIdentifier:  Constants.Cell.PopularCell, for: indexPath) as! PopularCell
                cell.configure(with : obj_individual_movie)
                cell.deleteThisCell = { [weak self] cellId in
                    // self?.arr_movies.remove(at: indexPath.row)
                    //  self?.collectionview.reloadData()
                    print("index from popular : \(indexPath.row)")
                    self?.collectionview?.performBatchUpdates{
                        
                        if let indexToDelete = self?.arr_movies.firstIndex(where: { $0.id == cellId }) {
                            self?.arr_movies.remove(at: indexToDelete)
                            let indexPathToDelete = IndexPath(item: indexToDelete, section: 0)
                            self?.collectionview?.deleteItems(at: [indexPathToDelete])
                        }
                    }
                }
                
                return cell
            }else {
                let cell = collectionview.dequeueReusableCell(withReuseIdentifier:  Constants.Cell.UnPopularCell, for: indexPath) as! UnPopularCell
                cell.configure(with : obj_individual_movie )
                cell.deleteThisCell = { [weak self] cellId in
                    print("index from UnPopularCell : \(indexPath.row)")
                    self?.collectionview?.performBatchUpdates{
                        
                        if let indexToDelete = self?.arr_movies.firstIndex(where: { $0.id == cellId }) {
                            self?.arr_movies.remove(at: indexToDelete)
                            let indexPathToDelete = IndexPath(item: indexToDelete, section: 0)
                            self?.collectionview?.deleteItems(at: [indexPathToDelete])
                        }
                    }
                    
                }
                return cell
            }
            
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Image code :
//        let detailScreenVC = DetailScreenVC()
//        detailScreenVC.imgPath =  ApiEndpoints.imgUrlPath + arr_movies[indexPath.item].posterPath
//        self.navigationController?.pushViewController(detailScreenVC, animated: false)
        
        // video code :
        
        let detailScreenVC = DetailScreenVCVideo()
        detailScreenVC.videoPath =  arr_movies[indexPath.item].videoUrl
        self.navigationController?.pushViewController(detailScreenVC, animated: false)
        
    }
}


// MARK: - search bar delegates
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          arr_filtered_movies = arr_movies.filter { data in

              return data.title.lowercased().contains(searchText.lowercased())
          }

          collectionview.reloadData()
      }
}
