//
//  NuevoComentarioDrController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class NuevoComentarioDrController: UIViewController {

    var nuevoComentario:String!
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        id = nuevoComentario
        print(id)
    }


    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }


}
