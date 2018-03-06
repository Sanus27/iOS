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
    
    var ref:DocumentReference!
    var getRef: Firestore!
    var uid:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRef = Firestore.firestore()
        self.uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document(self.uid)
        //dataUser()
    }
    
    
    func dataUser(){
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let lastname = val!["apellido"] as! String
                let name = val!["nombre"] as! String
                let avatar = val!["avatar"] as! String
               
                if avatar != "" {
                    Storage.storage().reference(forURL: avatar).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
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
                    
                }
                
            } else {
                print("documento no existe")
            }
        }
    }

    @IBAction func btnSignOff(_ sender: UIButton) {
        
        let alerts = UIAlertController(title: " Cerrar sesión", message: "¿Esta seguro cerrar su sesión?", preferredStyle: .alert);
        alerts.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.performSegue(withIdentifier: "salir", sender: self);
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
        }))
        alerts.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil ))
        self.present(alerts, animated: true, completion: nil);

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
