//
//  ConnectionManager.swift
//  TestRappi
//  https://developers.themoviedb.org/3/movies/get-movie-details
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation

class ConnectionManager: NSObject {
    
    // MARK: WS
    func getMovies(path:String, onCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: [Movie]) -> ()) {
        let ApiURL = String(format: Constants.ApiURL, path, Constants.KeyAPI)
        
        let httpMethod:HTTPMethod = .Get
        
        NetworkManager.sharedInstance.exec(httpMethod: httpMethod, urlString: ApiURL, headers: nil, parameters: nil, values: nil, body: nil, isJSON: true) { (success, msg, data) in
            var arrMovieEntity = [Movie]()
            let dicData: NSDictionary = data as? NSDictionary ?? [:]
            let results: NSArray = dicData["results"] as? NSArray ?? []
            
            let page = data["page"] ?? 0
            let total_results = data["total_results"] ?? 0
            let total_pages = data["total_pages"] ?? 0
            for element in results{
                arrMovieEntity.append(Movie(dic: element as! NSDictionary))
            }
            print("Rappi - page:\(page!) total_results:\(total_results!) total_pages:\(total_pages!)")
            onCompleted(success, msg, arrMovieEntity)
        }
    }
    
    
    // MARK: Shared Instance
    static let sharedInstance = ConnectionManager()
}
