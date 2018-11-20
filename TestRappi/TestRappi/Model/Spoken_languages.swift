//
//  Spoken_languages.swift
//  
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Spoken_languages: NSObject {

	var Idmovie: Int = 0
	var Iso_639_1: String = ""
	var Name: String = ""

override var description: String{
	return "****Spoken_languages****\n .Idmovie:\t\(Idmovie)\nIso_639_1:\t\(Iso_639_1)\nName:\t\(Name)\n****"
}

override init(){
}

init(Idmovie: Int,Iso_639_1: String,Name: String){
	self.Idmovie = Idmovie
	self.Iso_639_1 = Iso_639_1
	self.Name = Name
}

convenience init(dic: NSDictionary){
	let Idmovie: Int = dic["idmovie"] as? Int ?? 0
	let Iso_639_1: String = dic["iso_639_1"] as? String ?? ""
	let Name: String = dic["name"] as? String ?? ""

self.init(Idmovie:Idmovie,Iso_639_1:Iso_639_1,Name:Name)
}

func exportAsDictionary() -> NSDictionary{
	let Idmovie = self.Idmovie
	let Iso_639_1 = self.Iso_639_1
	let Name = self.Name

	let dict: NSDictionary = ["idmovie":Idmovie,"iso_639_1":Iso_639_1,"name":Name]

	return dict
}

 }
