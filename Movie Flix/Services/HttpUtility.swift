//
//  HttpUtility.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import Foundation
struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: Movies?)-> Void, errorCompletion : @escaping(_ error: String?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Movies.self, from: responseData!)
                 //   print(result)
                    _ = completionHandler(result)
                }
                catch let error{
                    _ = errorCompletion(error.localizedDescription)
                }
            }

        }.resume()
    }

    
}
