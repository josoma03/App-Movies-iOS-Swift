//
//  MovieDetailViewController.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import UIKit
class MovieDetailViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
 
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableDetail: UITableView!
    var idMovie = 0
    var objMovie = Movie()
    // MARK: - Cicle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchDetailMovie()
        self.initControls()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0: //detail
            return objMovie.Title
        case 1: //collection
            return Utils.stringNamed("Collection")
        case 2: //production
            return Utils.stringNamed("Production")
        case 3://videos
            return Utils.stringNamed("Videos")
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1 && self.objMovie.objBelogns.Name==""){
            return 0
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor=UIColor.white
        header.textLabel?.font = header.textLabel?.font.withSize(15)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: //detail
            return 1
        case 1: //collection
            return 1
        case 2: //production
            return self.objMovie.arrProdCompanies.count
        case 3://videos
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(indexPath.section == 1 && self.objMovie.objBelogns.Name==""){
            return 0
        }
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:DetailMovieCell = self.tableDetail.dequeueReusableCell(withIdentifier: "cellDetail") as! DetailMovieCell
            cell.initWithEntity(objMovie: objMovie)
            return cell
        case 1: //cellBelongs
            let cell:BelongViewCell = self.tableDetail.dequeueReusableCell(withIdentifier: "cellBelongs") as! BelongViewCell
            cell.initWithEntity(objBelogns: objMovie.objBelogns)
            return cell
        case 2:     //Production
            let cell:ProductionViewCell = self.tableDetail.dequeueReusableCell(withIdentifier: "cellProduction") as! ProductionViewCell
            cell.initWithEntity(objProduction: objMovie.arrProdCompanies[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    // MARK: - Other
    func initControls()
    {
        self.tableDetail.tableFooterView = UIView(frame: CGRect.zero)
       
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = true
    }
    
    /// Permite consultar el detalle de una pelicula
    func searchDetailMovie()
    {
        if Reachability.isConnectedToNetwork(){
            self.activityIndicator.isHidden = false
            
            ConnectionManager.sharedInstance.getDetailMovie(idMovie: idMovie) { (success, msg, data) in
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    
                    if(success){
                        self.objMovie = data
                        _ = Database.sharedInstance.insertMovie(self.objMovie)
                        self.showDetail()
                    }
                    else{
                        self.showToast(message: msg)
                    }
                }
            }
        }
        else{
            self.showToast(message: Utils.stringNamed("Working_offline"))
            //Obtener los resultados de la base de datos, para mostrarlos en pantalla
            self.objMovie = Database.sharedInstance.findMovie(SearchType.Movie.byId.Value, arguments: ["Id":self.idMovie])[0]
            self.showDetail()
        }
    }
    
    func showDetail()
    {
        Utils.animateTable(self.tableDetail)
        self.tableDetail.reloadData()
    }
    
}
