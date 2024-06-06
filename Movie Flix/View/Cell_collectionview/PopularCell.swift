//
//  PopularCell.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit
class PopularCell: UICollectionViewCell {
    let backgroundViewOfCell = UIView()
    let imageView = UIImageView()
    let btnDelete = UIButton()
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
        
       
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setPlaceHolderImage() // placeholder image
        contentView.addSubview(imageView)
        
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        btnDelete.tintColor = .red
        btnDelete.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        btnDelete.addTarget(self, action: #selector(self.deleteBtnPressed(sender:)), for: UIControl.Event.touchUpInside)
        contentView.addSubview(btnDelete)
        
        setupConstraints()
    }
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundViewOfCell.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor ,  constant: 5 ),
            backgroundViewOfCell.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor ,  constant: -5),
            backgroundViewOfCell.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.5),
            backgroundViewOfCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor ,  constant: -2.5),


            btnDelete.heightAnchor.constraint(equalToConstant: 25),
            btnDelete.widthAnchor.constraint(equalTo: btnDelete.heightAnchor),
            btnDelete.topAnchor.constraint(equalTo:  backgroundViewOfCell.topAnchor, constant: 5),
            btnDelete.trailingAnchor.constraint(equalTo:  backgroundViewOfCell.trailingAnchor, constant: -5),
               
            
            imageView.leadingAnchor.constraint(equalTo: backgroundViewOfCell.leadingAnchor , constant: 5.0),
            imageView.trailingAnchor.constraint(equalTo: backgroundViewOfCell.trailingAnchor, constant: -5.0),
            imageView.topAnchor.constraint(equalTo: backgroundViewOfCell.topAnchor, constant: 5.0),
            imageView.bottomAnchor.constraint(equalTo: backgroundViewOfCell.bottomAnchor, constant: -5.0)
        ])
        
       
    }
    
    func configure(with movie: Movie) {
        self.cellID = movie.id
        let backdrop_path =  ApiEndpoints.imgUrlPath + movie.backdropPath

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


