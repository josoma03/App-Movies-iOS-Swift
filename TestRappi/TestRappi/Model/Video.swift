//
//  Video.swift
//
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class VideoMovie: NSObject {
    
    var Id: String = ""
    var Iso_639_1: String = ""
    var Iso_3166_1: String = ""
    var Key: String = ""
    var Name: String = ""
    var Site: String = ""
    var Size: Int = 0
    var TypeVideo: String = ""
    
    override var description: String{
        return "****Video****\n Id:\t\(Id)\nIso_639_1:\t\(Iso_639_1)\nIso_3166_1:\t\(Iso_3166_1)\nKey:\t\(Key)\nName:\t\(Name)\nSite:\t\(Site)\nSize:\t\(Size)\nType:\t\(TypeVideo)\n********"
    }
    
    override init(){
    }
    
    init(Id: String,Iso_639_1: String,Iso_3166_1: String,Key: String,Name: String,Site: String,Size: Int,Type: String){
        self.Id = Id
        self.Iso_639_1 = Iso_639_1
        self.Iso_3166_1 = Iso_3166_1
        self.Key = Key
        self.Name = Name
        self.Site = Site
        self.Size = Size
        self.TypeVideo = Type
    }
    
    convenience init(dic: NSDictionary){
        let Id: String = dic["id"] as? String ?? ""
        let Iso_639_1: String = dic["iso_639_1"] as? String ?? ""
        let Iso_3166_1: String = dic["iso_3166_1"] as? String ?? ""
        let Key: String = dic["key"] as? String ?? ""
        let Name: String = dic["name"] as? String ?? ""
        let Site: String = dic["site"] as? String ?? ""
        let Size: Int = dic["size"] as? Int ?? 0
        let Type: String = dic["type"] as? String ?? ""
        
        self.init(Id:Id,Iso_639_1:Iso_639_1,Iso_3166_1:Iso_3166_1,Key:Key,Name:Name,Site:Site,Size:Size,Type:Type)
    }
    
    func exportAsDictionary() -> NSDictionary{
        let Id = self.Id
        let Iso_639_1 = self.Iso_639_1
        let Iso_3166_1 = self.Iso_3166_1
        let Key = self.Key
        let Name = self.Name
        let Site = self.Site
        let Size = self.Size
        let Type = self.TypeVideo
        
        let dict: NSDictionary = ["id":Id,"iso_639_1":Iso_639_1,"iso_3166_1":Iso_3166_1,"key":Key,"name":Name,"site":Site,"size":Size,"type":Type]
        
        return dict
    }
    
}

