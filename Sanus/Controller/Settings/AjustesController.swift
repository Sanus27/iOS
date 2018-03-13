//
//  AjustesController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AjustesController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    
    private var ref:DocumentReference!
    private var uid:String = ""
    private let alert = Alerts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document(self.uid)
        dataUser()
    }
    
    
    private func dataUser(){
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let lastname = val!["apellido"] as! String
                let name = val!["nombre"] as! String
                let avatar = val!["avatar"] as? String
                let fullname: String = name + " " + lastname
               
                if avatar != nil {
                    Storage.storage().reference(forURL: avatar!).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            print("fallo al traer imagenes", error)
                        } else {
                            self.avatar.image = UIImage(data: data!)
                            self.avatar.layer.masksToBounds = false
                            self.avatar.layer.cornerRadius = 25
                            self.avatar.clipsToBounds = true
                            self.avatar.layer.borderWidth = 1
                            self.txtName.text = name + " " + lastname
                        }
                    })
                    
                } else {
                    self.avatar.image = #imageLiteral(resourceName: "user")
                }
                
                self.txtName.text = fullname 
                
            } else {
                print("documento no existe")
            }
        }
    }

    @IBAction func btnSignOff(_ sender: UIButton) {
        self.alert.alertAvanced( this: self, titileAlert: "Cerrar sesión", bodyAlert: "¿Esta seguro cerrar su sesión?", actionAlert: "signOut")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
