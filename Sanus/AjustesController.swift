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
        let email = Auth.auth().currentUser?.email
        print("Correo del usuario: \(email!) ")
    }

    @IBAction func btnCerrarSesion(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "salir", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
