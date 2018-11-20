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
    @IBOutlet weak var tableListMovies: UITableView!
    var objMovie = Movie()
    
    // MARK: - Cicle life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //cellMovie
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
