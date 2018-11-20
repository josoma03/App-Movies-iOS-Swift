//
//  Genres.swift
//  
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Genres: NSObject {

	var Id: Int = 0
	var Idmovie: Int = 0
	var Name: String = ""

override var description: String{
	return "****Genres****\n .Id:\t\(Id)\nIdmovie:\t\(Idmovie)\nName:\t\(Name)\n****"
}

override init(){
}

init(Id: Int,Idmovie: Int,Name: String){
	self.Id = Id
	self.Idmovie = Idmovie
	self.Name = Name
}

convenience init(dic: NSDictionary){
	let Id: Int = dic["id"] as? Int ?? 0
	let Idmovie: Int = dic["idmovie"] as? Int ?? 0
	let Name: String = dic["name"] as? String ?? ""

self.init(Id:Id,Idmovie:Idmovie,Name:Name)
}

func exportAsDictionary() -> NSDictionary{
	let Id = self.Id
	let Idmovie = self.Idmovie
	let Name = self.Name

	let dict: NSDictionary = ["id":Id,"idmovie":Idmovie,"name":Name]

	return dict
}

 }
