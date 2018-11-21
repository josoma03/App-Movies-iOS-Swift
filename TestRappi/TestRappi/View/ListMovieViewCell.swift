//
//  MovieCell.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import UIKit

class ListMovieViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var imgVoteCount: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    
    func initWithEntity(objMovie: Movie)
    {
        let url = NSURL(string: "\(Constants.ImageURL)/\(Constants.PosterSizes[0])\(objMovie.Poster_path)")
        self.imgPoster.imageFromUrl((url?.absoluteString)!)
        
        lblOriginalLanguage.text = objMovie.Original_language.uppercased()
        lblVoteCount.text = objMovie.Vote_count.description
        lblTitle.text = objMovie.Title
        lblTitle.textColor = Utils.getColorFontBranding()
        lblReleaseDate.text = Utils.formatDate(objMovie.Release_date)
        txtOverview.text = objMovie.Overview
    }
}
