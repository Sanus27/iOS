//
//  CrearCuentaController.swift
//  Sanus
//
//  Created by Luis on 02/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class CrearCuentaController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPass1: UITextField!
    @IBOutlet weak var txtPass2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCrearCuenta(_ sender: UIButton) {
        if txtPass1.text == txtPass2.text {
    
            Auth.auth().createUser(withEmail: txtCorreo.text!, password: txtPass1.text!) { (user, error) in
                if user != nil {
                    print("Se ha creado la cuenta con exito")
                } else {
                    if let error = error?.localizedDescription {
                        print("error de firebase: ", error)
                    } else {
                        print("error de codigo")
                    }
                }
            }

            
        } else {
            print("mal")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
