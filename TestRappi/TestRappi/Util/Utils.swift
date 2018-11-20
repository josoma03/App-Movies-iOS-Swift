//
//  Utils.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 19/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//


import Foundation
import UIKit

class Utils
{
    
    /// Permite obtener el color asignado al branding: Rojo de Rappi
    ///
    /// - Returns: Color del branding
    class func getColorFontBranding() -> UIColor
    {
        return UIColor(red: 0.996, green: 0.376, blue: 0.314, alpha: 1.00)
    }
    
    
    /// Función para extraer las cadenas en diferentes idiomas
    ///
    /// - Parameter name: cadena sin internacionalizacion
    /// - Returns: cadena asignada al idioma configurado
    class func stringNamed(_ name: String) -> String
    {
        return NSLocalizedString(name, comment: "-")
    }
}
