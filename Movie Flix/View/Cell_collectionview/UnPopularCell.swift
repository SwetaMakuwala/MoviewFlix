//
//  UnPopularCell.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit
class UnPopularCell: UICollectionViewCell {
    
    
    let backgroundViewOfCell = UIView()
    let btnDelete = UIButton()
    let imageView = UIImageView()
    let lblTitle = UILabel()
    let lblOverview = UILabel()
    var cellID : Int = 0
    
    var deleteThisCell: ((_ id : Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        backgroundViewOfCell.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewOfCell.applyCornerRadius(5.0)
        backgroundViewOfCell.backgroundColor = .systemGray.withAlphaComponent(0.2)
        contentView.addSubview(backgroundViewOfCell)
        
   
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        btnDelete.tintColor = .red
        btnDelete.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        btnDelete.addTarget(self, action: #selector(self.deleteBtnPressed(sender:)), for: UIControl.Event.touchUpInside)
        contentView.addSubview(btnDelete)
        
        imageView.setPlaceHolderImage() // placeholder image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .systemFont(ofSize: 14, weight: .bold)
        contentView.addSubview(lblTitle)

        
        lblOverview.translatesAutoresizingMaskIntoConstraints = false
        lblOverview.font = .systemFont(ofSize: 10)
        lblOverview.numberOfLines = 0
        contentView.addSubview(lblOverview)
        
    
        setupConstraints()
    }
    private func setupConstraints() {
        

        NSLayoutConstraint.activate([

            backgroundViewOfCell.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor ,  constant: 5 ),
            backgroundViewOfCell.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor ,  constant: -5),
            backgroundViewOfCell.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.5),
            backgroundViewOfCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor ,  constant: -2.5),
            
            btnDelete.heightAnchor.constraint(equalToConstant: 25),
            btnDelete.widthAnchor.constraint(equalTo: btnDelete.heightAnchor),
            btnDelete.topAnchor.constraint(equalTo:  backgroundViewOfCell.topAnchor, constant: 5),
            btnDelete.trailingAnchor.constraint(equalTo:  backgroundViewOfCell.trailingAnchor, constant: -5),
            
            
            lblTitle.leadingAnchor.constraint(equalTo:  backgroundViewOfCell.leadingAnchor,constant: 5),
            lblTitle.trailingAnchor.constraint(equalTo:  backgroundViewOfCell.trailingAnchor, constant: -55),
            lblTitle.topAnchor.constraint(equalTo:  backgroundViewOfCell.topAnchor, constant: 0),
            lblTitle.heightAnchor.constraint(equalToConstant: 25),
            
            imageView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor , constant: 2.5),
            imageView.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9),
            
            lblOverview.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            lblOverview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            lblOverview.topAnchor.constraint(equalTo: imageView.topAnchor),
            lblOverview.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
       
        ])
    }
    
    func configure(with movie: Movie) {
        self.cellID = movie.id
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        let backdrop_path =  ApiEndpoints.imgUrlPath + movie.posterPath

        ImageDownloadManager.shared.loadImage(for: backdrop_path) { image in
            DispatchQueue.main.async {
               
                self.imageView.image = image
            }
        }
    }
    @objc func deleteBtnPressed(sender : UIButton)
    {
        deleteThisCell?(self.cellID)
    }
}
