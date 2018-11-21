//
//  Category_movie.swift
//
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Category_movie: NSObject {
    
    var Idmovie: Int = 0
    var Idcategory: Int = 0
    
    override var description: String{
        return "****Category_movie****\n Idmovie:\t\(Idmovie)\nIdcategory:\t\(Idcategory)\n********"
    }
    
    override init(){
    }
    
    init(Idmovie: Int,Idcategory: Int){
        self.Idmovie = Idmovie
        self.Idcategory = Idcategory
    }
    
    convenience init(dic: NSDictionary){
        let Idmovie: Int = dic["idmovie"] as? Int ?? 0
        let Idcategory: Int = dic["idcategory"] as? Int ?? 0
        
        self.init(Idmovie:Idmovie,Idcategory:Idcategory)
    }
    
    func exportAsDictionary() -> NSDictionary{
        let Idmovie = self.Idmovie
        let Idcategory = self.Idcategory
        
        let dict: NSDictionary = ["idmovie":Idmovie,"idcategory":Idcategory]
        
        return dict
    }
    
}

