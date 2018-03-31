//
//  ResumCitaController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class AddAppointmentController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCreate(_ sender: UIButton) {
        let alert = Alerts()
        alert.alertSimple( this: self, titileAlert: "Exito", bodyAlert: "Haz agendado una cita de manera exitosa", actionAlert: nil )
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
