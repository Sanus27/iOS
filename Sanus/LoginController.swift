//
//  ViewController.swift
//  Sanus
//
//  Created by Luis on 02/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
    }
    
    
    @IBAction func btnIniciarSesion(_ sender: UIButton) {
        self.load.startAnimating()
        Auth.auth().signIn(withEmail: txtCorreo.text!, password: txtPassword.text!) { ( user, error ) in
            
            self.load.stopAnimating()
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                if let error = error?.localizedDescription {
                    print("Error: ", error)
                } else {
                    print("error de codigo")
                }
            }
        }
    }
    
    func login(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                print("sesion no iniciada")
            } else {
                print("sesion hecha")
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
}

