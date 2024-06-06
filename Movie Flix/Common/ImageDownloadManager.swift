//
//  ImageDownloadManager.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import UIKit

class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(for urlString: String, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completionHandler(cachedImage)
            return
        }
        
        
        guard let url = URL(string: urlString) else { return }
        let concurrentQueue = DispatchQueue(label: "concurrentQueue", qos: .background, attributes: .concurrent)
        
        concurrentQueue.async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completionHandler(nil)
                    print(error)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    completionHandler(nil)
                    return
                }
                
                self.imageCache.setObject(image, forKey: NSString(string: urlString))
                completionHandler(image)
            }
            task.resume()
        }
    }
}
