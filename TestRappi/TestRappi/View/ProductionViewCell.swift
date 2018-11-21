//
//  ProductionViewCell.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 20/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit

class ProductionViewCell: UITableViewCell {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOriginCountry: UILabel!
    
    func initWithEntity(objProduction: Production_companies)
    {
        if(objProduction.Name != ""){
            let url = NSURL(string: "\(Constants.ImageURL)/\(Constants.PosterSizes[0])\(objProduction.Logo_path)")
            self.imgLogo.imageFromUrl((url?.absoluteString)!)
        }
        lblName.text = objProduction.Name
        lblOriginCountry.text = objProduction.Origin_country
    }
}
