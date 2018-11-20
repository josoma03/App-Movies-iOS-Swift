//
//  NetworkManager.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//


import UIKit

public enum HTTPMethod : Int {
    case Get
    case Post
    case Delete
    case Put
}

class NetworkManager: NSObject {
    
    func exec(httpMethod: HTTPMethod,
              urlString: String!,
              headers: [String:AnyObject]?,
              parameters: [String:AnyObject]?,
              values: [String:AnyObject]?,
              body: NSData?,
              isJSON: Bool,
              onCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: AnyObject) -> ()) {
        
        //print("Rappi - \(urlString ?? "")")
        let components = NSURLComponents(string: urlString)!
        if let parameters = parameters {
            var queryItems = [NSURLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = NSURLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            
            components.queryItems = queryItems as [URLQueryItem]
        }
        
        let request = NSMutableURLRequest(url: components.url!)
        
        switch httpMethod {
        case .Get:
            request.httpMethod = "GET"
        case .Post:
            request.httpMethod = "POST"
        case .Delete:
            request.httpMethod = "DELETE"
        case .Put:
            request.httpMethod = "PUT"
        }
        
        
        if let headers = headers {
            for (key,value) in headers {
                request.addValue(value as! String, forHTTPHeaderField: key)
            }
        }
        
        if let values = values {
            for (key,value) in values {
                request.setValue(value as? String, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = body as Data
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            var newData: NSData?
            var parsedResult: AnyObject?
            
            guard (error == nil) else {
                if let errorMessage = error?._userInfo?[NSLocalizedDescriptionKey] as? String {
                    onCompleted(false, errorMessage, [] as AnyObject)
                } else {
                    onCompleted(false, Utils.stringNamed("No_data_was_returned"), [] as AnyObject)
                }
                
                return
            }
            
            guard let data = data else {
                onCompleted(false, Utils.stringNamed("No_data_was_returned"), [] as AnyObject)
                return
            }
            
            newData = data as NSData
            
            if isJSON {
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: newData! as Data, options: .allowFragments) as AnyObject
                } catch {
                    onCompleted(false, Utils.stringNamed("Could_not_parse_the_data"), [] as AnyObject)
                }
            } else {
                parsedResult = newData
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                if let parsedResult = parsedResult {
                    if let errorMessage = parsedResult["error"] as? String {
                        onCompleted(false, errorMessage, [] as AnyObject)
                        
                    } else {
                        onCompleted(false, "\(Utils.stringNamed("Your_request_returned")) \((response as? HTTPURLResponse)?.statusCode ?? 0)", [] as AnyObject)
                    }
                } else {
                    onCompleted(false, "\(Utils.stringNamed("Your_request_returned")) \((response as? HTTPURLResponse)?.statusCode ?? 0)", [] as AnyObject)
                }
                
                return
            }
            
            onCompleted(true, "", parsedResult as AnyObject)
        }
        task.resume()
        
    }
    
    // MARK: Custom methods
    func fail(_ error: String, failure: (_ error: NSError?) -> Void) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey : error]
        failure(NSError(domain: "exec", code: 1, userInfo: userInfo))
    }
    
    // MARK: - Shared Instance
    static let sharedInstance = NetworkManager()
}
