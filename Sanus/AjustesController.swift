//
//  AjustesController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class AjustesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCerrarSesion(_ sender: UIButton) {
        
        let alerta = UIAlertController(title: " Cerrar sesión", message: "¿Esta seguro cerrar su sesión?", preferredStyle: .alert);
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.performSegue(withIdentifier: "salir", sender: self);
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
        }))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil ))
        self.present(alerta, animated: true, completion: nil);

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
