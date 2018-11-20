//
//  Belongs_to_collection.swift
//
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Belongs_to_collection: NSObject {
    
    var Id: Int = 0
    var Idmovie: Int = 0
    var Name: String = ""
    var Poster_path: String = ""
    var Backdrop_path: String = ""
    
    override var description: String{
        return "****Belongs_to_collection****\n .Id:\t\(Id)\nIdmovie:\t\(Idmovie)\nName:\t\(Name)\nPoster_path:\t\(Poster_path)\nBackdrop_path:\t\(Backdrop_path)\n****"
    }
    
    override init(){
    }
    
    init(Id: Int,Idmovie: Int,Name: String,Poster_path: String,Backdrop_path: String){
        self.Id = Id
        self.Idmovie = Idmovie
        self.Name = Name
        self.Poster_path = Poster_path
        self.Backdrop_path = Backdrop_path
    }
    
    convenience init(dic: NSDictionary){
        let Id: Int = dic["id"] as? Int ?? 0
        let Idmovie: Int = dic["idmovie"] as? Int ?? 0
        let Name: String = dic["name"] as? String ?? ""
        let Poster_path: String = dic["poster_path"] as? String ?? ""
        let Backdrop_path: String = dic["backdrop_path"] as? String ?? ""
        
        self.init(Id:Id,Idmovie:Idmovie,Name:Name,Poster_path:Poster_path,Backdrop_path:Backdrop_path)
    }
    
    func exportAsDictionary() -> NSDictionary{
        let Id = self.Id
        let Idmovie = self.Idmovie
        let Name = self.Name
        let Poster_path = self.Poster_path
        let Backdrop_path = self.Backdrop_path
        
        let dict: NSDictionary = ["id":Id,"idmovie":Idmovie,"name":Name,"poster_path":Poster_path,"backdrop_path":Backdrop_path]
        
        return dict
    }
    
}

