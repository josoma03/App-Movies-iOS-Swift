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
    
    
    /// Permite obtener un listado de peliculas dependiendo de la categoria
    ///
    /// - Parameters:
    ///   - idCategory: id de la categoria
    ///   - onCompleted: Bloque que se ejecuta el terminar la peticion
    func getMovies(query: String, idCategory:Int, onCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: [Movie]) -> ()) {
        
        var path:String = ""
        var urlString = Constants.ApiURL
        if(query == "" || idCategory != -1) //Buscar por categoria
        {
            switch idCategory
            {
            case 0:     //Popular
                path = Constants.Movies.Popular.Path
                break
            case 1:     //Top Rated
                path = Constants.Movies.TopRated.Path
                break
            case 2:     //Upcoming
                path = Constants.Movies.Upcoming.Path
                break
            default:     //Popular
                path = Constants.Movies.Popular.Path
                break
            }
        }
        else{                            //Buscar por texto
            path = Constants.Movies.Search.Path
            let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            urlString = "\(urlString)&query=\(queryEncoded)"
        }
        urlString = urlString.replacingOccurrences(of: "{path}", with: path)
        urlString = urlString.replacingOccurrences(of: "{key}", with: Constants.KeyAPI)
        
        let httpMethod:HTTPMethod = .Get
        
        NetworkManager.sharedInstance.exec(httpMethod: httpMethod, urlString: urlString, headers: nil, parameters: nil, values: nil, body: nil, isJSON: true) { (success, msg, data) in
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
    
    
    /// Permite obtener el detalle de una pelicula
    ///
    /// - Parameters:
    ///   - idMovie: id de la pelicula
    ///   - onCompleted: Bloque que se ejecuta el terminar la peticion
    func getDetailMovie(idMovie:Int, onCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: Movie) -> ()) {
        var urlString = Constants.ApiURL
        urlString = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Details.Path)
        urlString = urlString.replacingOccurrences(of: "{id}", with: "\(idMovie)")
        urlString = urlString.replacingOccurrences(of: "{key}", with: Constants.KeyAPI)
        
        let httpMethod:HTTPMethod = .Get
        
        NetworkManager.sharedInstance.exec(httpMethod: httpMethod, urlString: urlString, headers: nil, parameters: nil, values: nil, body: nil, isJSON: true) { (success, msg, data) in
            let dicData: NSDictionary = data as? NSDictionary ?? [:]
            let objMovie = Movie(dic: dicData)
            onCompleted(success, msg, objMovie)
        }
    }
    
    
    /// Permite obtener un listado de videos asociados a una pelicula
    ///
    /// - Parameters:
    ///   - idMovie: id de la pelicula
    ///   - onCompleted: Bloque que se ejecuta el terminar la peticion
    func getVideos(idMovie:Int, onCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: [VideoMovie]) -> ()) {
        var urlString = Constants.ApiURL
        urlString = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Videos.Path)
        urlString = urlString.replacingOccurrences(of: "{id}", with: "\(idMovie)")
        urlString = urlString.replacingOccurrences(of: "{key}", with: Constants.KeyAPI)
        
        let httpMethod:HTTPMethod = .Get
        
        NetworkManager.sharedInstance.exec(httpMethod: httpMethod, urlString: urlString, headers: nil, parameters: nil, values: nil, body: nil, isJSON: true) { (success, msg, data) in
            var arrVideo = [VideoMovie]()
            let dicData: NSDictionary = data as? NSDictionary ?? [:]
            let results: NSArray = dicData["results"] as? NSArray ?? []
            
            for element in results{
                arrVideo.append(VideoMovie(dic: element as! NSDictionary))
            }
            
            onCompleted(success, msg, arrVideo)
        }
    }
    
    
    // MARK: Shared Instance
    static let sharedInstance = ConnectionManager()
}
