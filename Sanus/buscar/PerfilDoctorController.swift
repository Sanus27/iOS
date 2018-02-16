//
//  PerfilDoctorController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PerfilDoctorController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var txtCV: UITextView!
    @IBOutlet weak var txtEspecialidad: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtCedula: UILabel!
    
    var verPerfil:Doctores!
    var ref: DocumentReference!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = verPerfil.id!
        ref = Firestore.firestore().collection("doctores").document(id)
        mostrar()
    }
    
    func mostrar(){
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let nombre = val!["nombre"] as! String
                print(nombre)
                self.navbar.title = nombre
                let foto = val!["avatar"] as! String
                print(foto)
                let cv = val!["cv"] as! String
                print(cv)
                self.txtCV.text = cv
                let especialidad = val!["especialidad"] as! String
                print(especialidad)
                self.txtEspecialidad.text = especialidad
                let cedula = val!["cedula"] as! String
                print(cedula)
                self.txtCedula.text = cedula
                
                if foto != "" {
                    Storage.storage().reference(forURL: foto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            print("fallo al traer imagenes", error)
                        } else {
                            self.avatar.image = UIImage(data: data!)
                            self.avatar.layer.masksToBounds = false
                            self.avatar.layer.cornerRadius = self.avatar.frame.height / 2
                            self.avatar.clipsToBounds = true
                            self.avatar.layer.borderWidth = 1
                        }
                    })
                    
                }
                
            } else {
                print("documento no existe")
            }
        }
    }
    
    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
    
}
