//
//  NuevaCitaController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class ClinicaCitaController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("seleciona tu clinica")
    }

    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        print("atras...")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSiguiente(_ sender: UIBarButtonItem) {
        print("siguiente...")
    }
    
}
