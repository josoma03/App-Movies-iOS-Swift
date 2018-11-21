//
//  Production_companies.swift
//
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Production_companies: NSObject {
    
    var Id: Int = 0
    var Idmovie: Int = 0
    var Logo_path: String = ""
    var Name: String = ""
    var Origin_country: String = ""
    
    override var description: String{
        return "****Production_companies****\n .Id:\t\(Id)\nIdmovie:\t\(Idmovie)\nLogo_path:\t\(Logo_path)\nName:\t\(Name)\nOrigin_country:\t\(Origin_country)\n****"
    }
    
    override init(){
    }
    
    init(Id: Int,Idmovie: Int,Logo_path: String,Name: String,Origin_country: String){
        self.Id = Id
        self.Idmovie = Idmovie
        self.Logo_path = Logo_path
        self.Name = Name
        self.Origin_country = Origin_country
    }
    
    convenience init(dic: NSDictionary){
        let Id: Int = dic["id"] as? Int ?? 0
        let Idmovie: Int = dic["idmovie"] as? Int ?? 0
        let Logo_path: String = dic["logo_path"] as? String ?? ""
        let Name: String = dic["name"] as? String ?? ""
        let Origin_country: String = dic["origin_country"] as? String ?? ""
        
        self.init(Id:Id,Idmovie:Idmovie,Logo_path:Logo_path,Name:Name,Origin_country:Origin_country)
    }
    
    func exportAsDictionary() -> NSDictionary{
        let Id = self.Id
        let Idmovie = self.Idmovie
        let Logo_path = self.Logo_path
        let Name = self.Name
        let Origin_country = self.Origin_country
        
        let dict: NSDictionary = ["id":Id,"idmovie":Idmovie,"logo_path":Logo_path,"name":Name,"origin_country":Origin_country]
        
        return dict
    }
    
}

