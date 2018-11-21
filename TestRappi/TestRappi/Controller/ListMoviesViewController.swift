//
//  ViewController.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource,UISearchBarDelegate, FilterDelegate {
    
    @IBOutlet weak var iconProfile: UIBarButtonItem!
    @IBOutlet weak var viewNotFound: UIView!
    @IBOutlet weak var lblNotFound: UILabel!
    @IBOutlet weak var segmentedCategory: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableListMovies: UITableView!
    
    var arrMovies = [Movie]()
    var indexSelected = 0
    var refreshControl: UIRefreshControl!           // varible para la sincronizacion de la tabla
    
    // MARK: - Cicle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initControls()
        self.searchMoviesByCategory()
    }
    
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListMovieViewCell = self.tableListMovies.dequeueReusableCell(withIdentifier: "cellMovie") as! ListMovieViewCell
        cell.initWithEntity(objMovie: arrMovies[indexPath.row])
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
        self.refreshControl?.addTarget(self, action: #selector(ListMoviesViewController.searchMoviesByCategory), for: UIControl.Event.valueChanged)
        let attributes = [NSAttributedString.Key.foregroundColor: Utils.getColorFontBranding()]
        let attributedTitle = NSAttributedString(string: Utils.stringNamed("Searching"), attributes: attributes)
        self.refreshControl.attributedTitle = attributedTitle
        self.tableListMovies.addSubview(refreshControl)
        
        //Personalizacion segmentedCategory
        self.segmentedCategory.setTitle(Utils.stringNamed("Popular"), forSegmentAt: 0)
        self.segmentedCategory.setTitle(Utils.stringNamed("Top_Rated"), forSegmentAt: 1)
        self.segmentedCategory.setTitle(Utils.stringNamed("Upcoming"), forSegmentAt: 2)
        self.segmentedCategory.tintColor = Utils.getColorFontBranding()
        
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
            destinationController.idMovie = arrMovies[indexSelected].Idmovie
        }
        if segue.identifier == "gotoFilter"{
            let destinationController = segue.destination as! FilterViewController
            destinationController.delegate = self
        }
    }
    
    
    /// Permite realizar la busqueda de las peliculas, cuando la categoria ha cambiado
    ///
    /// - Parameter sender: categoria seleccionada
    @IBAction func categoryChanged(_ sender: Any) {
        self.searchMoviesByCategory()
    }
    
    @IBAction func btnFilterAction(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoFilter", sender: self)
    }
    
    
    /// Permite realizar la busqueda de la peliculas con el WS
    @objc func searchMovies(objFilterQuery: FilterQuery, idCategory: Int)
    {
        self.view.endEditing(true)
        if Reachability.isConnectedToNetwork(){
            self.activityIndicator.isHidden = false
            ConnectionManager.sharedInstance.getMovies(objFilterQuery:objFilterQuery, idCategory: idCategory) { (success, msg, arrMovies) in
                DispatchQueue.main.async {
                    if(success){
                        if(idCategory != -1){                   //Solo se guardan cuando se busca por categoria
                            self.insertAllMoviesDB(arrMovies)
                        }
                        self.arrMovies = arrMovies
                        self.showResults()
                    }
                    else{
                        self.activityIndicator.isHidden = true
                        self.showToast(message: msg)
                    }
                }
            }
        }
        else{
            self.showToast(message: Utils.stringNamed("Working_offline"))
            //Obtener los resultados de la base de datos, para mostrarlos en pantalla
            self.arrMovies = Database.sharedInstance.findMovie(SearchType.Movie.byCategory.Value, arguments: ["Id":segmentedCategory.selectedSegmentIndex])
            self.showResults()
        }
    }
    
    
    /// Permite guardar el resultado en la base de datos
    ///
    /// - Parameter arrMovies: arreglo de peliculas que retorna el WS
    func insertAllMoviesDB(_ arrMovies:[Movie])
    {
        _ = Database.sharedInstance.deleteCategory_movie(SearchType.Category_movie.byCategory.Value, arguments: ["Id":self.segmentedCategory.selectedSegmentIndex])
        for objMovie in arrMovies
        {
            _ = Database.sharedInstance.insertMovie(objMovie)
            _ = Database.sharedInstance.insertCategory_movie(Category_movie(Idmovie: objMovie.Idmovie, Idcategory: self.segmentedCategory.selectedSegmentIndex))
        }
    }
    
    /// Permite mostrar los resultados
    func showResults()
    {
        self.refreshControl!.endRefreshing()
        self.activityIndicator.isHidden = true
        if(self.arrMovies.count == 0)
        {
            self.tableListMovies.isHidden = true
            self.viewNotFound.isHidden = false
        }
        else{
            Utils.animateTable(self.tableListMovies)
            self.tableListMovies.isHidden = false
            self.viewNotFound.isHidden = true
        }
    }
    
    
    @objc func searchMoviesByCategory()
    {
        self.searchMovies(objFilterQuery: FilterQuery(), idCategory: segmentedCategory.selectedSegmentIndex)
    }
    
    // MARK: - FilterDelegate
    func filterMovies(_ objFilterQuery: FilterQuery) {
        self.searchMovies(objFilterQuery: objFilterQuery , idCategory: -1)
    }
   
}

