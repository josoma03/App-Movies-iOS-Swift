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
        //return UIColor(red: 0.996, green: 0.376, blue: 0.314, alpha: 1.00)  //Color Rappi
        return UIColor(red: 0.894, green: 0.031, blue: 0.078, alpha: 1.00)
    }
    
    
    /// Función para extraer las cadenas en diferentes idiomas
    ///
    /// - Parameter name: cadena sin internacionalizacion
    /// - Returns: cadena asignada al idioma configurado
    class func stringNamed(_ name: String) -> String
    {
        return NSLocalizedString(name, comment: "-")
    }
    
    
    
    /// Permite aplicar un formato a la fecha "yyyy-MM-dd"
    ///
    /// - Parameter date: fecha en formato "yyyy-MM-dd"
    /// - Returns: fecha en formato "MMM dd,yyyy"
    class func formatDate(_ date:String) ->String
    {
        var dateFormatted = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            dateFormatted = dateFormatterPrint.string(from: date)
        }
        return dateFormatted
    }
    
    
    /// /// Permite realizar una animacion hacia arriba al recargar la tabla
    class func animateTable(_ table: UITableView) {
        table.reloadData()
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            
        }
        var index = 0
        for a in cells {
            table.isHidden = false
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
    
    
    
    /// Permite aplicar el formato a los numeros: 162000.0.kFormatted  // "$162K"
    ///
    /// - Parameter number: numero
    /// - Returns: string con el formato "$144K"
    class func getFormatFloatingPoint(_ number: Int)->String
    {
        var format = "%d"
        var  value = number
        
        if(number < 1000)
        {
            format = "%d"
            value = number
        }
        else{
            if(number >= 1000000)
            {
                format = "%dM"
                value = number/1000000
            }
            else{
                format = "%dK"
                value = number/1000
            }
        }
        return String(format: format,  value)
    }
    
    /// Crea animacion de cambio de tamaño
    ///
    /// - Parameter label: componenente
    class func animateLabel(_ label: UIView)
    {
        let duration: TimeInterval = 2
        label.layer.anchorPoint = CGPoint(x: 0, y: 0)
        label.layer.position = CGPoint(x: 0, y: 0)
        
        label.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        UIView.animate(withDuration: duration) {
            label.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
 
}
