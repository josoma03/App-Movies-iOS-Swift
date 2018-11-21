//
//  Database.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation

struct SearchType {
    
    /// Tipo de búsqueda de Genres a realizar en la base de datos.
    struct Genres{
        struct byId {
            static let Value = 1
        }
    }

    /// Tipo de búsqueda de Belongs_to_collection a realizar en la base de datos.
    struct Belongs{
        struct byId {
            static let Value = 1
        }
    }

    /// Tipo de búsqueda de Production_countries a realizar en la base de datos.
    struct Production{
        struct byId {
            static let Value = 1
        }
    }

    /// Tipo de búsqueda de Production_companies a realizar en la base de datos.
    struct Production_companies{
        struct byId {
            static let Value = 1
        }
    }

    /// Tipo de búsqueda de Movie a realizar en la base de datos.
    struct Movie{
        struct byId {
            static let Value = 1
        }
        struct byCategory {
            static let Value = 2
        }
    }
    /// Tipo de búsqueda de Spoken_languages a realizar en la base de datos.
    struct Spoken_languages{
        struct byId {
            static let Value = 1
        }
    }
    
    /// Tipo de búsqueda de Category_movie a realizar en la base de datos.
    struct Category_movie{
        struct byCategory{
            static let Value = 1
        }
    }
}

/**
 Clase auxiliar para realizar la conexión con la base de datos SQLite utilizada en la aplicación.
 */
class Database {
    
    var databasePath: NSString = NSString()
    
    init(){
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let myPath = URL(fileURLWithPath: docsDir).appendingPathComponent("rappi.sqlite")
        self.databasePath = myPath.path as NSString
        
    }
  
    
    
    
    // MARK: - GENRES
    
    /// Permite ingresar a la base de datos un registro Genres
    ///
    /// - Parameter rev: Objeto de tipo Genres
    func insertGenres(_ objGenres: Genres)->Bool{
        let Name = scapeString(objGenres.Name)
        let insertSQL = "INSERT OR REPLACE INTO GENRES (Id,Idmovie,Name) VALUES (\(objGenres.Id),\(objGenres.Idmovie),'\(Name)')"
        return self.executeSQL(insertSQL)
    }
    
    /// Permite ingresar un registro Genres
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findGenres(_ searchType: Int, arguments: NSDictionary) -> [Genres]{
        var arrResponse = [Genres]()
        var querySQL = ""
        switch searchType{
        case SearchType.Genres.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM GENRES WHERE Id = \(id)"
            break
        default:
            break
        }
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Id = results.long(forColumn: "ID")
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Name = results.string(forColumn: "NAME") ?? ""
                
                
                let objGenres = Genres(Id: Id,Idmovie: Idmovie,Name: Name)
                arrResponse.append(objGenres)
            }
            db?.close()
        }
        return arrResponse
    }
    /// Permite eliminar un registro Genres
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteGenres(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Genres.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM GENRES WHERE Id = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - BELONGS_TO_COLLECTION
    
    /// Permite ingresar a la base de datos un registro Belongs_to_collection
    ///
    /// - Parameter rev: Objeto de tipo Belongs_to_collection
    func insertBelongs_to_collection(_ objBelongs: Belongs_to_collection)->Bool{
        let Name = scapeString(objBelongs.Name)
        let Poster_path = scapeString(objBelongs.Poster_path)
        let Backdrop_path = scapeString(objBelongs.Backdrop_path)
        let insertSQL = "INSERT OR REPLACE INTO BELONGS_TO_COLLECTION (Id,Idmovie,Name,Poster_path,Backdrop_path) VALUES (\(objBelongs.Id),\(objBelongs.Idmovie),'\(Name)','\(Poster_path)','\(Backdrop_path)')"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Belongs_to_collection
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findBelongs_to_collection(_ searchType: Int, arguments: NSDictionary) -> [Belongs_to_collection]{
        var arrResponse = [Belongs_to_collection]()
        var querySQL = ""
        switch searchType{
        case SearchType.Belongs.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM BELONGS_TO_COLLECTION WHERE Id = \(id)"
            break
        default:
            break
        }
        
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Id = results.long(forColumn: "ID")
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Name = results.string(forColumn: "NAME") ?? ""
                let Poster_path = results.string(forColumn: "POSTER_PATH") ?? ""
                let Backdrop_path = results.string(forColumn: "BACKDROP_PATH") ?? ""
                
                
                let objBelongs = Belongs_to_collection(Id: Id,Idmovie: Idmovie,Name: Name,Poster_path: Poster_path,Backdrop_path: Backdrop_path)
                arrResponse.append(objBelongs)
            }
            db?.close()
        }
        
        return arrResponse
    }
    /// Permite eliminar un registro Belongs_to_collection
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteBelongs_to_collection(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Belongs.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM BELONGS_TO_COLLECTION WHERE Id = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - PRODUCTION_COUNTRIES
    
    /// Permite ingresar a la base de datos un registro Production_countries
    ///
    /// - Parameter rev: Objeto de tipo Production_countries
    func insertProduction_countries(_ objProduction_countries: Production_countries)->Bool{
        let Iso_3166_1 = scapeString(objProduction_countries.Iso_3166_1)
        let Name = scapeString(objProduction_countries.Name)
        let insertSQL = "INSERT OR REPLACE INTO PRODUCTION_COUNTRIES (Idmovie,Iso_3166_1,Name) VALUES (\(objProduction_countries.Idmovie),'\(Iso_3166_1)','\(Name)')"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Production_countries
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findProduction_countries(_ searchType: Int, arguments: NSDictionary) -> [Production_countries]{
        var arrResponse = [Production_countries]()
        var querySQL = ""
        switch searchType{
        case SearchType.Production.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM PRODUCTION_COUNTRIES WHERE  = \(id)"
            break
        default:
            break
        }
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Iso_3166_1 = results.string(forColumn: "ISO_3166_1") ?? ""
                let Name = results.string(forColumn: "NAME") ?? ""
                
                
                let objProduction_countries = Production_countries(Idmovie: Idmovie,Iso_3166_1: Iso_3166_1,Name: Name)
                arrResponse.append(objProduction_countries)
            }
            db?.close()
        }
        
        return arrResponse
    }
    /// Permite eliminar un registro Production_countries
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteProduction_countries(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Production.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM PRODUCTION_COUNTRIES WHERE  = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - SPOKEN_LANGUAGES
    
    /// Permite ingresar a la base de datos un registro Spoken_languages
    ///
    /// - Parameter rev: Objeto de tipo Spoken_languages
    func insertSpoken_languages(_ objSpoken_languages: Spoken_languages)->Bool{
        let Iso_639_1 = scapeString(objSpoken_languages.Iso_639_1)
        let Name = scapeString(objSpoken_languages.Name)
        let insertSQL = "INSERT OR REPLACE INTO SPOKEN_LANGUAGES (Idmovie,Iso_639_1,Name) VALUES (\(objSpoken_languages.Idmovie),'\(Iso_639_1)','\(Name)')"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Spoken_languages
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findSpoken_languages(_ searchType: Int, arguments: NSDictionary) -> [Spoken_languages]{
        var arrResponse = [Spoken_languages]()
        var querySQL = ""
        switch searchType{
        case SearchType.Spoken_languages.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM SPOKEN_LANGUAGES WHERE  = \(id)"
            break
        default:
            break
        }
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Iso_639_1 = results.string(forColumn: "ISO_639_1") ?? ""
                let Name = results.string(forColumn: "NAME") ?? ""
                
                
                let objSpoken_languages = Spoken_languages(Idmovie: Idmovie,Iso_639_1: Iso_639_1,Name: Name)
                arrResponse.append(objSpoken_languages)
            }
            db?.close()
        }

        return arrResponse
    }
    /// Permite eliminar un registro Spoken_languages
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteSpoken_languages(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Spoken_languages.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM SPOKEN_LANGUAGES WHERE  = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - PRODUCTION_COMPANIES
    
    /// Permite ingresar a la base de datos un registro Production_companies
    ///
    /// - Parameter rev: Objeto de tipo Production_companies
    func insertProduction_companies(_ objProduction_companies: Production_companies)->Bool{
        let Logo_path = scapeString(objProduction_companies.Logo_path)
        let Name = scapeString(objProduction_companies.Name)
        let Origin_country = scapeString(objProduction_companies.Origin_country)
        let insertSQL = "INSERT OR REPLACE INTO PRODUCTION_COMPANIES (Id,Idmovie,Logo_path,Name,Origin_country) VALUES (\(objProduction_companies.Id),\(objProduction_companies.Idmovie),'\(Logo_path)','\(Name)','\(Origin_country)')"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Production_companies
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findProduction_companies(_ searchType: Int, arguments: NSDictionary) -> [Production_companies]{
        var arrResponse = [Production_companies]()
        var querySQL = ""
        switch searchType{
        case SearchType.Production_companies.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM PRODUCTION_COMPANIES WHERE Id = \(id)"
            break
        default:
            break
        }
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Id = results.long(forColumn: "ID")
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Logo_path = results.string(forColumn: "LOGO_PATH") ?? ""
                let Name = results.string(forColumn: "NAME") ?? ""
                let Origin_country = results.string(forColumn: "ORIGIN_COUNTRY") ?? ""
                
                
                let objProduction_companies = Production_companies(Id: Id,Idmovie: Idmovie,Logo_path: Logo_path,Name: Name,Origin_country: Origin_country)
                arrResponse.append(objProduction_companies)
            }
            db?.close()
        }
        
        return arrResponse
    }
    /// Permite eliminar un registro Production_companies
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteProduction_companies(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Production_companies.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM PRODUCTION_COMPANIES WHERE Id = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - MOVIE
    
    /// Permite ingresar a la base de datos un registro Movie
    ///
    /// - Parameter rev: Objeto de tipo Movie
    func insertMovie(_ objMovie: Movie)->Bool{
        let Backdrop_path = scapeString(objMovie.Backdrop_path)
        let Homepage = scapeString(objMovie.Homepage)
        let Imdb_id = scapeString(objMovie.Imdb_id)
        let Original_language = scapeString(objMovie.Original_language)
        let Original_title = scapeString(objMovie.Original_title)
        let Overview = scapeString(objMovie.Overview)
        let Poster_path = scapeString(objMovie.Poster_path)
        let Status = scapeString(objMovie.Status)
        let Tagline = scapeString(objMovie.Tagline)
        let Title = scapeString(objMovie.Title)
        let Release_date = scapeString(objMovie.Release_date)
        
        let insertSQL = "INSERT OR REPLACE INTO MOVIE (Idmovie,Adult,Backdrop_path,Budget,Homepage,Imdb_id,Original_language,Original_title,Overview,Popularity,Poster_path,Release_date,Revenue,Runtime,Status,Tagline,Title,Video,Vote_average,Vote_count) VALUES (\(objMovie.Idmovie),'\(objMovie.Adult)','\(Backdrop_path)',\(objMovie.Budget),'\(Homepage)','\(Imdb_id)','\(Original_language)','\(Original_title)','\(Overview)',\(objMovie.Popularity),'\(Poster_path)','\(Release_date)',\(objMovie.Revenue),\(objMovie.Runtime),'\(Status)','\(Tagline)','\(Title)','\(objMovie.Video)',\(objMovie.Vote_average),\(objMovie.Vote_count))"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Movie
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findMovie(_ searchType: Int, arguments: NSDictionary) -> [Movie]{
        var arrResponse = [Movie]()
        var querySQL = ""
        switch searchType{
        case SearchType.Movie.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM MOVIE WHERE Idmovie = \(id)"
            break
        case SearchType.Movie.byCategory.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT M.* FROM MOVIE M INNER JOIN CATEGORY_MOVIE C ON (M.IDMOVIE= C.IDMOVIE) WHERE C.IDCATEGORY = \(id)"
            break
            
        default:
            break
        }
        
        
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Adult = results.long(forColumn: "ADULT")
                let Backdrop_path = results.string(forColumn: "BACKDROP_PATH") ?? ""
                let Budget = results.long(forColumn: "BUDGET")
                let Homepage = results.string(forColumn: "HOMEPAGE") ?? ""
                let Imdb_id = results.string(forColumn: "IMDB_ID") ?? ""
                let Original_language = results.string(forColumn: "ORIGINAL_LANGUAGE") ?? ""
                let Original_title = results.string(forColumn: "ORIGINAL_TITLE") ?? ""
                let Overview = results.string(forColumn: "OVERVIEW") ?? ""
                let Popularity = results.double(forColumn: "POPULARITY")
                let Poster_path = results.string(forColumn: "POSTER_PATH") ?? ""
                let Revenue = results.long(forColumn: "REVENUE")
                let Runtime = results.long(forColumn: "RUNTIME")
                let Status = results.string(forColumn: "STATUS") ?? ""
                let Tagline = results.string(forColumn: "TAGLINE") ?? ""
                let Title = results.string(forColumn: "TITLE") ?? ""
                let Video = results.long(forColumn: "VIDEO")
                let Vote_average = results.double(forColumn: "VOTE_AVERAGE")
                let Vote_count = results.long(forColumn: "VOTE_COUNT")
                let Release_date = results.string(forColumn: "RELEASE_DATE") ?? ""
                
                
                let objMovie = Movie(Idmovie: Idmovie,Adult: Adult,Backdrop_path: Backdrop_path,Budget: Budget,Homepage: Homepage,Imdb_id: Imdb_id,Original_language: Original_language,Original_title: Original_title,Overview: Overview,Popularity: Popularity,Poster_path: Poster_path,Release_date: Release_date,Revenue: Revenue,Runtime: Runtime,Status: Status,Tagline: Tagline,Title: Title,Video: Video,Vote_average: Vote_average,Vote_count: Vote_count)
                arrResponse.append(objMovie)
            }
            db?.close()
        }
        return arrResponse
    }
    
    
    /// Permite eliminar un registro Movie
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteMovie(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Movie.byId.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM MOVIE WHERE Idmovie = \(id)"
            break
        case SearchType.Movie.byCategory.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM MOVIE WHERE Idcategory = \(id)"
            break
        default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    // MARK: - CATEGORY_MOVIE
    
    /// Permite ingresar a la base de datos un registro Category_movie
    ///
    /// - Parameter rev: Objeto de tipo Category_movie
    func insertCategory_movie(_ objCategory_movie: Category_movie)->Bool{
        let insertSQL = "INSERT INTO CATEGORY_MOVIE (Idmovie,Idcategory) VALUES (\(objCategory_movie.Idmovie),\(objCategory_movie.Idcategory))"
        return self.executeSQL(insertSQL)
    }
    /// Permite ingresar un registro Category_movie
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de busqueda
    ///   - arguments: argumentos para realiza la busqueda
    /// - Returns: Arreglo con los registros encontrados
    func findCategory_movie(_ searchType: Int, arguments: NSDictionary) -> [Category_movie]{
        var arrResponse = [Category_movie]()
        var querySQL = ""
        switch searchType{
        case SearchType.Category_movie.byCategory.Value:
            let id: Int = arguments["Id"]!as!Int
            querySQL = "SELECT * FROM CATEGORY_MOVIE WHERE IDCATEGORY= \(id)"
            break
        default:
            break
        }
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            while results.next() == true{
                let Idmovie = results.long(forColumn: "IDMOVIE")
                let Idcategory = results.long(forColumn: "IDCATEGORY")
                
                
                let objCategory_movie = Category_movie(Idmovie: Idmovie,Idcategory: Idcategory)
                arrResponse.append(objCategory_movie)
            }
            db?.close()
        }
        return arrResponse
    }
    /// Permite eliminar un registro Category_movie
    ///
    /// - Parameters:
    ///   - searchType: Indica el tipo de eliminacion
    ///   - arguments: argumentos para realiza la eliminacion
    /// - Returns: Booleano que indica el exito de la operacion
    func deleteCategory_movie(_ searchType: Int, arguments: NSDictionary)->Bool{
        var deleteSQL = ""
        switch searchType{
        case SearchType.Category_movie.byCategory.Value:
            let id: Int = arguments["Id"]!as!Int
            deleteSQL = "DELETE FROM CATEGORY_MOVIE WHERE idCategory = \(id)"
            break
            default:
            break
        }
        return self.executeStatements(deleteSQL)
    }
    
    
    
    
    
    /// Permite escapar los textos que contienen comillas
    ///
    /// - Parameter value: Valor del campo
    /// - Returns: Nuevo valor del campo, escapado
    func scapeString(_ value:String)->String
    {
        let newValue = value.replacingOccurrences(of: "'", with: "''", options: NSString.CompareOptions.regularExpression, range: nil)
        return newValue
    }
    
    
    /// Permite ejecutar una sentencia de SQL
    ///
    /// - Parameter deleteSQL: sentencia sql
    /// - Returns: resultado de la operacion
    func executeStatements(_ deleteSQL: String) -> Bool
    {
        var succeded = false
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())!{
            let result = db?.executeStatements(deleteSQL, withResultBlock: nil)
            
            if !result! {
            } else {
                succeded = true
            }
            db?.close()
        } else {
        }
        return succeded
    }
    
    
    
    /// Permite ejecutar una sentencia INSERT/UPDATE
    ///
    /// - Parameter updateSQL: sentencia sql (INSERT/UPDATE)
    /// - Returns: resultado de la operacion
    func executeSQL(_ updateSQL: String) -> Bool
    {
        var succeded = false
        let db = FMDatabase(path: databasePath as String)
        
        if (db?.open())!{
            let result = db?.executeUpdate(updateSQL, withArgumentsIn: nil)
            
            if !result! {
            } else {
                succeded = true
            }
            db?.close()
        } else {
        }
        return succeded
    }
   
    
    // MARK: Shared Instance
    static let sharedInstance = Database()
}
