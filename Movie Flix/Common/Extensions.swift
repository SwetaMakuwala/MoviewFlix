//
//  Extensions.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit

extension UIImageView{
    func setPlaceHolderImage(){
        self.image = UIImage(systemName: "photo")
    }
}

extension UIView{
    func applyCornerRadius(_ value : Double){
        self.layer.cornerRadius = value
    }
}
