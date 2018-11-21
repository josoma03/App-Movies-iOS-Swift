//
//  FilterViewController.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 21/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit


protocol FilterDelegate{
    func filterMovies(_ objFilterQuery: FilterQuery)
}
class FilterViewController:UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtQuery: UITextField!
    @IBOutlet weak var txtReleaseYear: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var switchAdults: UISwitch!
    var delegate : FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchAdults.tintColor = Utils.getColorFontBranding()
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        if(txtQuery.text == "")
        {
            self.showToast(message: Utils.stringNamed("query_must_be_provided"))
        }
        else{
            let objFilterQuery = FilterQuery()
            objFilterQuery.IncludeAdult = (switchAdults.isOn) ? "true" : "false"
            objFilterQuery.PrimaryReleaseYear = txtReleaseYear.text!
            objFilterQuery.Year = txtYear.text!
            objFilterQuery.Query = txtQuery.text!
            delegate?.filterMovies(objFilterQuery)
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == txtYear || textField == txtReleaseYear)
        {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            
            return string == numberFiltered && count <= 4
        }
        return true
    }
   
}
