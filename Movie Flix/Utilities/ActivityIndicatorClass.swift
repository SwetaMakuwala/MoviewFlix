//
//  ActivityIndicatorClass.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit
class ActivityIndicatorClass{
    static let shared = ActivityIndicatorClass()
    var indicator = UIActivityIndicatorView()
    
    func presentActivityIndicator(vc : UIViewController) {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = vc.view.center
        indicator.backgroundColor = .white
        indicator.startAnimating()
        
        vc.view.addSubview(indicator)
    }
    
    func removeActivityIndicator(vc : UIViewController){
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        indicator.removeFromSuperview()
    }
    
}
