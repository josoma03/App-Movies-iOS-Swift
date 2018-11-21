//
//  Movie.swift
//
//
//  Created by Jhonattan Solarte Martinez
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Movie: NSObject {
    
    var Idmovie: Int = 0
    var Adult: Int = 0
    var Backdrop_path: String = ""
    var Budget: Int = 0
    var Homepage: String = ""
    var Imdb_id: String = ""
    var Original_language: String = ""
    var Original_title: String = ""
    var Overview: String = ""
    var Popularity: Double = 0.0
    var Poster_path: String = ""
    var Release_date: String = ""
    var Revenue: Int = 0
    var Runtime: Int = 0
    var Status: String = ""
    var Tagline: String = ""
    var Title: String = ""
    var Video: Int = 0
    var Vote_average: Double = 0.0
    var Vote_count: Int = 0
    var objBelogns = Belongs_to_collection()
    var objGenres = [Genres]()
    var arrProdCompanies = [Production_companies]()
    var arrProdCountries = [Production_countries]()
    var arrSpokenLang = [Spoken_languages]()
    var arrVideos = [VideoMovie]()
    
    override var description: String{
        return "****Movie****\n Idmovie:\t\(Idmovie)\nAdult:\t\(Adult)\nBackdrop_path:\t\(Backdrop_path)\nBudget:\t\(Budget)\nHomepage:\t\(Homepage)\nImdb_id:\t\(Imdb_id)\nOriginal_language:\t\(Original_language)\nOriginal_title:\t\(Original_title)\nOverview:\t\(Overview)\nPopularity:\t\(Popularity)\nPoster_path:\t\(Poster_path)\nRelease_date:\t\(Release_date)\nRevenue:\t\(Revenue)\nRuntime:\t\(Runtime)\nStatus:\t\(Status)\nTagline:\t\(Tagline)\nTitle:\t\(Title)\nVideo:\t\(Video)\nVote_average:\t\(Vote_average)\nVote_count:\t\(Vote_count)\nobjBelogns:\t\(objBelogns)\nobjGenres:\t\(objGenres)\narrProdCompanies:\t\(arrProdCompanies)\narrProdCountries:\t\(arrProdCountries)\narrSpokenLang:\t\(arrSpokenLang)****"
    }
    
    override init(){
    }
    
    init(Idmovie: Int,Adult: Int,Backdrop_path: String,Budget: Int,Homepage: String,Imdb_id: String,Original_language: String,Original_title: String,Overview: String,Popularity: Double,Poster_path: String,Release_date: String,Revenue: Int,Runtime: Int,Status: String,Tagline: String,Title: String,Video: Int,Vote_average: Double,Vote_count: Int){
        self.Idmovie = Idmovie
        self.Adult = Adult
        self.Backdrop_path = Backdrop_path
        self.Budget = Budget
        self.Homepage = Homepage
        self.Imdb_id = Imdb_id
        self.Original_language = Original_language
        self.Original_title = Original_title
        self.Overview = Overview
        self.Popularity = Popularity
        self.Poster_path = Poster_path
        self.Release_date = Release_date
        self.Revenue = Revenue
        self.Runtime = Runtime
        self.Status = Status
        self.Tagline = Tagline
        self.Title = Title
        self.Video = Video
        self.Vote_average = Vote_average
        self.Vote_count = Vote_count
    }
    
    convenience init(dic: NSDictionary){
        let Idmovie: Int = dic["id"] as? Int ?? 0
        let Adult: Int = dic["adult"] as? Int ?? 0
        let Backdrop_path: String = dic["backdrop_path"] as? String ?? ""
        let Budget: Int = dic["budget"] as? Int ?? 0
        let Homepage: String = dic["homepage"] as? String ?? ""
        let Imdb_id: String = dic["imdb_id"] as? String ?? ""
        let Original_language: String = dic["original_language"] as? String ?? ""
        let Original_title: String = dic["original_title"] as? String ?? ""
        let Overview: String = dic["overview"] as? String ?? ""
        let Popularity: Double = dic["popularity"] as? Double ?? 0
        let Poster_path: String = dic["poster_path"] as? String ?? ""
        let Release_date: String = dic["release_date"] as? String ?? ""
        let Revenue: Int = dic["revenue"] as? Int ?? 0
        let Runtime: Int = dic["runtime"] as? Int ?? 0
        let Status: String = dic["status"] as? String ?? ""
        let Tagline: String = dic["tagline"] as? String ?? ""
        let Title: String = dic["title"] as? String ?? ""
        let Video: Int = dic["video"] as? Int ?? 0
        let Vote_average: Double = dic["vote_average"] as? Double ?? 0
        let Vote_count: Int = dic["vote_count"] as? Int ?? 0
 self.init(Idmovie:Idmovie,Adult:Adult,Backdrop_path:Backdrop_path,Budget:Budget,Homepage:Homepage,Imdb_id:Imdb_id,Original_language:Original_language,Original_title:Original_title,Overview:Overview,Popularity:Popularity,Poster_path:Poster_path,Release_date:Release_date,Revenue:Revenue,Runtime:Runtime,Status:Status,Tagline:Tagline,Title:Title,Video:Video,Vote_average:Vote_average,Vote_count:Vote_count)
        
        self.objBelogns = Belongs_to_collection(dic: dic["belongs_to_collection"] as? NSDictionary ?? [:])
        for item in (dic["genres"] as? NSArray ?? [])
        {
            self.objGenres.append(Genres(dic: item as! NSDictionary))
        }
        for item in (dic["production_companies"] as? NSArray ?? [])
        {
            self.arrProdCompanies.append(Production_companies(dic: item as! NSDictionary))
        }
        for item in (dic["production_countries"] as? NSArray ?? [])
        {
            self.arrProdCountries.append(Production_countries(dic: item as! NSDictionary))
        }
        for item in (dic["spoken_languages"] as? NSArray ?? [])
        {
            self.arrSpokenLang.append(Spoken_languages(dic: item as! NSDictionary))
        }
    }
    
    func exportAsDictionary() -> NSDictionary{
        let Idmovie = self.Idmovie
        let Adult = self.Adult
        let Backdrop_path = self.Backdrop_path
        let Budget = self.Budget
        let Homepage = self.Homepage
        let Imdb_id = self.Imdb_id
        let Original_language = self.Original_language
        let Original_title = self.Original_title
        let Overview = self.Overview
        let Popularity = self.Popularity
        let Poster_path = self.Poster_path
        let Release_date = self.Release_date
        let Revenue = self.Revenue
        let Runtime = self.Runtime
        let Status = self.Status
        let Tagline = self.Tagline
        let Title = self.Title
        let Video = self.Video
        let Vote_average = self.Vote_average
        let Vote_count = self.Vote_count
        
        let dict: NSDictionary = ["id":Idmovie,"adult":Adult,"backdrop_path":Backdrop_path,"budget":Budget,"homepage":Homepage,"imdb_id":Imdb_id,"original_language":Original_language,"original_title":Original_title,"overview":Overview,"popularity":Popularity,"poster_path":Poster_path,"release_date":Release_date,"revenue":Revenue,"runtime":Runtime,"status":Status,"tagline":Tagline,"title":Title,"video":Video,"vote_average":Vote_average,"vote_count":Vote_count]
        
        return dict
    }
    
    
    
    /// Crea una cadena con todos los lenguajes hablados, separados por coma
    func getSpokenLanguages()->String
    {
        var strSpokenLanguages = ""
        
        for item in self.arrSpokenLang
        {
            strSpokenLanguages = "\(item.Name), \(strSpokenLanguages)"
        }
        return String(strSpokenLanguages.dropLast(2))
    }
    
    /// Crea una cadena con todos los generos, separados por coma
    func getGenres()->String
    {
        var strGenres = ""
        
        for item in self.objGenres
        {
            strGenres = "\(item.Name), \(strGenres)"
        }
        return String(strGenres.dropLast(2))
    }
    
    /// Crea una cadena con todos los generos, separados por coma
    func getProdCountries()->String
    {
        var strProdCountries = ""
        
        for item in self.arrProdCountries
        {
            strProdCountries = "\(item.Name), \(strProdCountries)"
        }
        return String(strProdCountries.dropLast(2))
    }
    
    
}

