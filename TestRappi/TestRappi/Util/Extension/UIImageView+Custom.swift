//
//  UIImageView+Custom.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 20/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            }); 
            task.resume()
        }
    }
    
    
    
}
