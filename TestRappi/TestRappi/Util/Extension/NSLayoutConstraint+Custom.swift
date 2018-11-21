//
//  NSLayoutConstraint+Custom.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 21/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
