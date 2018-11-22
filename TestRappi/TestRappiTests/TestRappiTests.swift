//
//  TestRappiTests.swift
//  TestRappiTests
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import XCTest
@testable import TestRappi

class TestRappiTests: XCTestCase {

    var sessionUnderTest: URLSession!
    let idMovie = 338952
    var urlPopular :String!
    var urlTopRated :String!
    var urlUpcoming :String!
    var urlMovieDetail :String!
    var urlMovieVideos :String!
    var urlSearchMovies :String!
    
    var controllerUnderTest: ListMoviesViewController!
    
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        
        let urlString = Constants.ApiURL.replacingOccurrences(of: "{key}", with: Constants.KeyAPI)
        
        urlPopular = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Popular.Path)
        urlTopRated = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.TopRated.Path)
        urlUpcoming = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Upcoming.Path)
        urlSearchMovies = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Search.Path)
        
        urlMovieDetail = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Details.Path)
        urlMovieDetail = urlMovieDetail.replacingOccurrences(of: "{id}", with: "\(idMovie)")
        
        urlMovieVideos = urlString.replacingOccurrences(of: "{path}", with: Constants.Movies.Videos.Path)
        urlMovieVideos = urlMovieVideos.replacingOccurrences(of: "{id}", with: "\(idMovie)")

       
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        controllerUnderTest = (nav.topViewController as! ListMoviesViewController)
       
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
   

    
    /// Asynchronous test: success fast, failure slow MOVIES Popular
    func testValidCallMoviesPopularHTTPStatusCode200() {
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlPopular)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES TopRated
    func testValidCallMoviesTopRatedHTTPStatusCode200() {
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlTopRated)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES Upcoming
    func testValidCallMoviesUpcomingHTTPStatusCode200() {
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlUpcoming)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES Details
    func testValidCallMovieDetailsHTTPStatusCode200() {
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieDetail)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    /// Asynchronous test: success fast, failure slow MOVIES Videos
    func testValidCallMovieVideosHTTPStatusCode200() {
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieVideos)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES Search
    func testValidCallSearchMoviesHTTPStatusCode200() {
        let objFilterQuery = FilterQuery(Query: "Bohemian")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }

    
    /// Asynchronous test: faster fail MOVIES Popular
    func testCallToMoviesPopularCompletes() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlPopular)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
    /// Asynchronous test: faster fail MOVIES TopRated
    func testCallToMoviesTopRatedCompletes() {
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlTopRated)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    /// Asynchronous test: faster fail MOVIES Upcoming
    func testCallToMoviesUpcomingCompletes() {
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlUpcoming)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    /// Asynchronous test: faster fail MOVIES Detail
    func testCallToMoviesDetailCompletes() {
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieDetail)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
    /// Asynchronous test: faster fail MOVIES Videos
    func testCallToMoviesVideosCompletes() {
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieVideos)!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    /// Asynchronous test: faster fail MOVIES Videos
    func testCallToSearchMoviesCompletes() {
        let objFilterQuery = FilterQuery(Query: "A")
        let promise = expectation(description: "Completion handler invoked")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
    
    /// Asynchronous test: success fast, failure slow MOVIES Details
    func testValidCallMovieDetailsHTTPStatusCode404() {
        urlMovieDetail = urlMovieDetail.replacingOccurrences(of: "\(idMovie)", with: "0")
        let promise = expectation(description: "Status code: 404")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieDetail)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 404 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES Videos
    func testValidCallMovieVideosHTTPStatusCode404() {
        urlMovieVideos = urlMovieDetail.replacingOccurrences(of: "\(idMovie)", with: "0")
        let promise = expectation(description: "Status code: 404")
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: urlMovieVideos)!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 404 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES SEARCH
    /// Validacion de busqueda de peliculas, sin el parametro obligatorio QUERY
    func testValidCallSearchMovieHTTPStatusCode422() {
        let objFilterQuery = FilterQuery(Query: "")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        let promise = expectation(description: "Status code: 404")
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 422 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES SEARCH
    /// Validacion de busqueda de una pelicula que no existe, con parametro QUERY,
    func testValidCallSearchMoviesNotFound() {
        let objFilterQuery = FilterQuery(IncludeAdult: "true", Query: "0123456789")
        let promise = expectation(description: "Result movies 0 TOTAL RESULTS")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    do {
                        if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                            let total_results: Int = (response["total_results"] as! Int)
                            
                            if(total_results == 0){
                                promise.fulfill()
                            }
                            else{
                                XCTFail("Error search movies: \(total_results)")
                            }
                        }
                        else{
                            XCTFail("Error json data")
                        }
                    } catch let error as NSError {
                        XCTFail("Error parsing results: \(error.localizedDescription)")
                    }
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    
    /// Asynchronous test: success fast, failure slow MOVIES Search
    /// Valida que los parametros arrojen una busqueda de adultos
    func testValidCallSearchMoviesAdults() {
        let objFilterQuery = FilterQuery(IncludeAdult: "true", Query: "Private Gold 7: Kruger Park")
        let promise = expectation(description: "Result movies adults")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    do {
                        if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                            let total_results: Int = (response["total_results"] as! Int)
                            
                            if(total_results > 0){
                                promise.fulfill()
                            }
                            else{
                                XCTFail("Error search movies adults: \(total_results)")
                            }
                        }
                        else{
                            XCTFail("Error json data")
                        }
                    } catch let error as NSError {
                        XCTFail("Error parsing results: \(error.localizedDescription)")
                    }
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Asynchronous test: success fast, failure slow MOVIES Search
    /// Valida que los parametros NO devuelvan peliculas para adultos, ya que IncludeAdult = "false"
    func testValidCallSearchMoviesAdultsValidateNotIncludeAdult() {
        let objFilterQuery = FilterQuery(IncludeAdult: "false", Query: "Private Gold 7: Kruger Park")
        let promise = expectation(description: "Result movies adults")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    do {
                        if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                            let total_results: Int = (response["total_results"] as! Int)
                            
                            if(total_results == 0){
                                promise.fulfill()
                            }
                            else{
                                XCTFail("Error search movies adults: \(total_results)")
                            }
                        }
                        else{
                            XCTFail("Error json data")
                        }
                    } catch let error as NSError {
                        XCTFail("Error parsing results: \(error.localizedDescription)")
                    }
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    // Fake URLSession with DHURLSession protocol and stubs
    // Simulamos la respuesta la recibe el controlador del listado de peliculas
    func test_UpdateSearchResults_ParsesData() {
        XCTAssertEqual(controllerUnderTest?.arrMovies.count, 0, "Los resultados de la búsqueda deben estar vacíos antes de que se ejecute la tarea de datos")
       
        let objFilterQuery = FilterQuery(Query: "Bohemian")
        let url = URL(string: "\(urlSearchMovies!)\(objFilterQuery.getParameters())")!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    
                    do {
                        if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                            let results: NSArray = response["results"] as? NSArray ?? []
                            var arrMovieEntity = [Movie]()
                            for element in results{
                                arrMovieEntity.append(Movie(dic: element as! NSDictionary))
                            }
                            promise.fulfill()
                            self.controllerUnderTest?.arrMovies = arrMovieEntity
                        }
                        else{
                            print("Error json data")
                        }
                    } catch let error as NSError {
                        print("Error parsing results: \(error.localizedDescription)")
                    }
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertGreaterThan((controllerUnderTest?.arrMovies.count)!, 0, "El servicio respondio con mas de 1 resultado")
    }
    
    // Performance
    func test_SearchMovies_Performance() {
        measure {
            self.controllerUnderTest?.searchMovies(objFilterQuery: FilterQuery(Query: "A"), idCategory: -1)
        }
    }
    
}
