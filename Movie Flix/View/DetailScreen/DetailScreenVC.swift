//
//  DetailScreenVC.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit

class DetailScreenVC: BaseVC {
    var imgPath : String = ""
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        showIndicator()
        ImageDownloadManager.shared.loadImage(for: imgPath) { image in
            DispatchQueue.main.async {
                self.hideIndicator()
                self.imageView.image = image
            }
        }
    }
    
    private func setUpUI(){
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        imageView.setPlaceHolderImage()
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor ,  constant: 5 ),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor ,  constant: -5),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 2.5),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor ,  constant: -2.5),
        ])
    }
    

}
