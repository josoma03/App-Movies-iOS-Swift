//
//  FilterQuery.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 21/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation

class FilterQuery: NSObject {
    
    var IncludeAdult: String = ""
    var Query: String = ""
    var Year: String = ""
    var PrimaryReleaseYear: String = ""
    
    override init(){
        self.IncludeAdult = "false"
        self.Query = ""
        self.Year = ""
        self.PrimaryReleaseYear = ""
    }
    
    init(IncludeAdult:String, Query:String, Year:String, PrimaryReleaseYear: String){
        self.IncludeAdult = IncludeAdult
        self.Query = Query
        self.Year = Year
        self.PrimaryReleaseYear = PrimaryReleaseYear
    }
    
    init(IncludeAdult:String, Query:String){
        self.IncludeAdult = IncludeAdult
        self.Query = Query
        self.Year = ""
        self.PrimaryReleaseYear = ""
    }
    init( Query:String){
        self.IncludeAdult = ""
        self.Query = Query
        self.Year = ""
        self.PrimaryReleaseYear = ""
    }
    
    func getParameters()->String
    {
        let queryEncoded = self.Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        var path = "&query=\(queryEncoded)&include_adult=\(IncludeAdult)"
        if(PrimaryReleaseYear != "")
        {
            path = "\(path)&primary_release_year=\(PrimaryReleaseYear)"
        }
        if(Year != "")
        {
            path = "\(path)&year=\(Year)"
        }
        return path
    }
}

