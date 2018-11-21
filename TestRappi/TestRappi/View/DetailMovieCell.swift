//
//  DetailMovieCell.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 20/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTagline: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    
    @IBOutlet weak var txtOverview: UITextView!
    
    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var lblHomepage: UILabel!
    @IBOutlet weak var lblSpoken_languages: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblProductionCountries: UILabel!
    
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblRevenue: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    
    
    func initWithEntity(objMovie: Movie)
    {
        if(objMovie.Idmovie != 0){
            let url = NSURL(string: "\(Constants.ImageURL)/\(Constants.PosterSizes[0])\(objMovie.Poster_path)")
            self.imgPoster.imageFromUrl((url?.absoluteString)!)
        }
        lblTitle.text = objMovie.Title
        lblTagline.text = objMovie.Tagline
        lblTitle.textColor = Utils.getColorFontBranding()
        
        lblStatus.text = objMovie.Status
        lblReleaseDate.text = Utils.formatDate(objMovie.Release_date)
        lblOriginalLanguage.text = objMovie.Original_language.uppercased()
        
        txtOverview.text = objMovie.Overview
        txtOverview.setContentOffset(.zero, animated: true)
        txtOverview.flashScrollIndicators()
        
        lblOriginalTitle.text = "\(Utils.stringNamed("original_title")): \(objMovie.Original_title)"
        lblHomepage.text = "\(Utils.stringNamed("homepage")): \(objMovie.Homepage)"
        lblSpoken_languages.text = "\(Utils.stringNamed("spoken_languages")): \(objMovie.getSpokenLanguages())"
        lblGenres.text = "\(Utils.stringNamed("genres")): \(objMovie.getGenres())"
        lblProductionCountries.text = "\(Utils.stringNamed("Production_countries")): \(objMovie.getProdCountries())"
        
        
        lblBudget.text = "$\(Utils.getFormatFloatingPoint(objMovie.Budget))"
        lblRevenue.text = "$\(Utils.getFormatFloatingPoint(objMovie.Revenue))"
        lblPopularity.text = objMovie.Popularity.description
        lblVoteAverage.text = objMovie.Vote_average.description
        lblVoteCount.text = Utils.getFormatFloatingPoint(objMovie.Vote_count)
        
    }
    
}
