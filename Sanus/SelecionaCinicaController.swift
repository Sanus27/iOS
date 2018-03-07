//
//  NuevaCitaController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SelecionaCinicaController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func btnNext(_ sender: UIButton) {
        print("NextPage")
    }
    
    
    @IBAction func btnAtras(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
}
