//
//  ViewController.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    @IBOutlet weak var iconProfile: UIBarButtonItem!
    @IBOutlet weak var viewNotFound: UIView!
    @IBOutlet weak var lblNotFound: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableListMovies: UITableView!
    var arrMovies = [Movie]()
    var indexSelected = 0
    var refreshControl: UIRefreshControl!           // varible para la sincronizacion de la tabla
    
    // MARK: - Cicle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initControls()
        self.searchMovies()
    }


    // MARK: - UITableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMovies.count
    }
    
   
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = self.tableListMovies.dequeueReusableCell(withIdentifier: "cellMovie") as! MovieCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.indexSelected = indexPath.row
        self.performSegue(withIdentifier: "gotoMovieDetail", sender: self)
    }
    
    
    // MARK: - Other
    func initControls()
    {
        //Personalizacion refreshControl
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ListMoviesViewController.searchMovies), for: UIControl.Event.valueChanged)
        let attributes = [NSAttributedString.Key.foregroundColor: Utils.getColorFontBranding()]
        let attributedTitle = NSAttributedString(string: Utils.stringNamed("Searching"), attributes: attributes)
        self.refreshControl.attributedTitle = attributedTitle
        self.tableListMovies.addSubview(refreshControl)
        
        //Personalizacion segmentedControl
        self.segmentedControl.setTitle(Utils.stringNamed("Popular"), forSegmentAt: 0)
        self.segmentedControl.setTitle(Utils.stringNamed("Top_Rated"), forSegmentAt: 1)
        self.segmentedControl.setTitle(Utils.stringNamed("Upcoming"), forSegmentAt: 2)
        self.segmentedControl.tintColor = Utils.getColorFontBranding()
        
        self.tableListMovies.tableFooterView = UIView(frame: CGRect.zero)
        
        self.iconProfile.tintColor = Utils.getColorFontBranding()
        
        self.lblNotFound.text = Utils.stringNamed("found_no_results")
        self.lblNotFound.textColor = Utils.getColorFontBranding()
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = Utils.getColorFontBranding()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoMovieDetail"{
            let destinationController = segue.destination as! MovieDetailViewController
            destinationController.objMovie = arrMovies[indexSelected]
        }
    }
    
    
    /// Permite realizar la busqueda de las peliculas, cuando la categoria ha cambiado
    ///
    /// - Parameter sender: categoria seleccionada
    @IBAction func categoryChanged(_ sender: Any) {
        searchMovies()
    }

    
    /// Permite realizar la busqueda de la peliculas con el WS
    @objc func searchMovies()
    {
        var path:String = ""
        self.activityIndicator.isHidden = false
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:     //Popular
                path = Constants.Movies.Popular.Path
            break
            case 1:     //Top Rated
                path = Constants.Movies.TopRated.Path
            break
            case 2:     //Upcoming
                path = Constants.Movies.Upcoming.Path
            break
            default:     //Popular
                path = Constants.Movies.Popular.Path
            break
        }
        
        ConnectionManager.sharedInstance.getMovies(path: path) { (success, msg, arrMovies) in
            DispatchQueue.main.async(execute: { () -> Void in
                self.arrMovies = arrMovies
                
                self.activityIndicator.isHidden = true
                if(self.arrMovies.count == 0)
                {
                    self.tableListMovies.isHidden = true
                    self.viewNotFound.isHidden = false
                    
                    if(success){
                        self.lblNotFound.text = Utils.stringNamed("found_no_results")
                    }
                    else{
                        self.lblNotFound.text = msg
                    }
                }
                else{
                    self.tableListMovies.isHidden = false
                    self.viewNotFound.isHidden = true
                }
            })
        }
        
       
    }
}

