//
//  BaseVC.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showIndicator() {
        ActivityIndicatorClass.shared.presentActivityIndicator(vc: self)
    }
    
    func hideIndicator(){
        ActivityIndicatorClass.shared.removeActivityIndicator(vc:self)
    }
   

}
