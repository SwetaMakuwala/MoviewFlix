//
//  ViewModel_Movies.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import Foundation
struct ViewModel
{
    func get_Movies(completion: @escaping(_ result : [Movie]?) -> Void, errorCompletion:@escaping(_ error  : String?) -> Void )
    {
        let httpUtility = HttpUtility()

        guard  let requestUrl = URL(string:ApiEndpoints.urlMovie) else {return }
        
        httpUtility.getApiData(requestUrl: requestUrl, resultType: Movies.self) {
            (response : Movies?) in
            if let movies = response{
                _ = completion(response)
            }
      
        } errorCompletion: { error in
            _ = errorCompletion(error)
        }

    }
}

