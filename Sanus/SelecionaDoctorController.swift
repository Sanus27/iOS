//
//  SelectDoctorCitasController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//


import UIKit

class SelecionaDoctorController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
