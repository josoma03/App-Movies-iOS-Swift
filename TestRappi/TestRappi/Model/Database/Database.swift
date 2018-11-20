//
//  Database.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//
//
//  database.swift
//  AFLS
//
//  Created by Alejandro Maya on 15/04/15.
//  Copyright (c) 2015 Aranda Software. All rights reserved.
//

import Foundation

/**
 Clase auxiliar para realizar la conexión con la base de datos SQLite utilizada en la aplicación. Contiene los métodos que se utilizan a lo largo de la aplicación para la escritura y lectura de registros en la base de datos.
 */
class database {
    
    var databasePath: NSString = NSString()
    
    init(){
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let myPath = URL(fileURLWithPath: docsDir).appendingPathComponent("rappi.sqlv")
        self.databasePath = myPath.path as NSString
        
    }
    
    
    func getRecords(querySQL: String)->FMResultSet
    {
        var results:FMResultSet = FMResultSet()
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            results = db?.executeQuery(querySQL, withArgumentsIn: nil) ?? FMResultSet()
            db?.close()
        }
        
        return results
    }
    
    func getAllTablesName()
    {
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let querySQL = "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name desc"
            let results:FMResultSet? = db?.executeQuery(querySQL, withArgumentsIn: nil)
            
            while results?.next() == true{
                let name = results?.string(forColumn: "name") ?? ""
                print("Tabla: \(name)")
            }
            db?.close()
        } else {
        }
        
        
    }
    
    
    /**
     * Permite atraves de una sql, obtener el primer y uno escalar
     */
    func getNumberFromDB(_ querySQL: String) -> Int
    {
        var number: Int = 0
        let db = FMDatabase(path: databasePath as String)
        if (db?.open())! {
            let results:FMResultSet? = db?.executeQuery(querySQL, withArgumentsIn: nil)
            
            while results?.next() == true{
                number = results!.long(forColumn: "cantidad")
            }
            db?.close()
        }
        
        return number
    }
    
    /**
     * Permite ejecutar una sentencia INSERT/UPDATE
     */
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
    
    
    /**
     * Permite ejecutar una sentencia de SQL
     */
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
    
    
    
    // MARK: - Common
    func getMaxValueForColumn(_ column: String, inTable table: String) -> Int{
        var max = 0
        let db = FMDatabase(path: databasePath as String)
        
        if (db?.open())! {
            let querySQL = "SELECT max(\(column)) FROM \(table)"
            let results:FMResultSet? = db?.executeQuery(querySQL, withArgumentsIn: nil)
            
            if results?.next() == true{
                max = results?.long(forColumn: "max(\(column))") ?? 0
            }
            db?.close()
        } else {
        }
        return max
    }
    
}
