//
//  DetailScreenVCVideo.swift
//  Movie Flix
//
//  Created by sweta makuwala on 06/06/24.
//

import UIKit
import WebKit

class DetailScreenVCVideo: BaseVC {
    var videoPath : String = ""
    var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
  
        let webConfiguration = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        self.view.addSubview(wkWebView)
   
        if let videoURL = URL(string: videoPath) {
            let requestObj = URLRequest(url: videoURL)
            self.wkWebView.load(requestObj)
        }
        setupConstraints()
       
    }

    
    private func setupConstraints() {
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            wkWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor ,  constant: 5 ),
            wkWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor ,  constant: -5),
            wkWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 2.5),
            wkWebView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor ,  constant: -2.5),
        ])
    }
    

}

// MARK: - webview delegates
extension DetailScreenVCVideo :  WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showIndicator()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideIndicator()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AlertManager.shared.showAlert(title: error.localizedDescription, message: nil, viewController: self)
        self.hideIndicator()
    }
}
