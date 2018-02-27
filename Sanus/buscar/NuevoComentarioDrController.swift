//
//  NuevoComentarioDrController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NuevoComentarioDrController: UIViewController {

    @IBOutlet var collectionStar: [UIButton]!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var btnComentarEditing: UIButton!
    @IBOutlet weak var txtComentario: UITextField!
    var nuevoComentario:String!
    var id = ""
    var uid = ""
    var ref:DocumentReference!
    var ref2:DocumentReference!
    var getRef: Firestore!
    var calif = 0
    var califi = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = nuevoComentario
        btnComentarEditing.isEnabled = false
        getRef = Firestore.firestore()
        uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document(uid)
        ref2 = Firestore.firestore().collection("doctores").document(id)
        comprobar();
    }
    
    
    @IBAction func comentarioEditing(_ sender: UITextField) {
        let num = Int(txtComentario.text!.count);
        if num > 0 {
            btnComentarEditing.isEnabled = true
        } else {
            btnComentarEditing.isEnabled = false
        }
    }
    
    func comprobar(){
        load.startAnimating()
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let foto = val!["avatar"] as! String
                
                if foto != "" {
                    Storage.storage().reference(forURL: foto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            print("fallo al traer imagenes", error)
                        } else {
                            self.avatar.image = UIImage(data: data!)
                            self.avatar.layer.masksToBounds = false
                            self.avatar.layer.cornerRadius = 25
                            self.avatar.clipsToBounds = true
                            self.avatar.layer.borderWidth = 1
                            self.load.stopAnimating()
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
    
    @IBAction func btnComentar(_ sender: UIButton) {
        if txtComentario.text != "" {
            
            load.startAnimating()
            let date = Date()
            let formater = DateFormatter()
            formater.dateStyle = .short
            formater.timeStyle = .none
            let fecha = formater.string(from: date)
            let cal:String = String(calif)
            ref = Firestore.firestore().collection("comentarios").addDocument(data: [
                "usuario": uid,
                "doctor": id,
                "comentario": txtComentario.text!,
                "fecha": fecha,
                "calificacion": cal
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.load.stopAnimating()
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                    self.load.stopAnimating()
                    self.txtComentario.text = ""
                    self.calificaciones( campos: cal )
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        } else {
            
            let alerta = UIAlertController(title: "Alerta", message: "Para poder enviar el comentario debes escribir algo", preferredStyle: .alert);
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
            alerta.addAction(aceptar);
            self.present(alerta, animated: true, completion: nil);
            
        }

    }
    
    func calificaciones( campos:String ) {
        print("tu calificacion es: \(campos)")
        ref2.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                var puntaje = val!["calificacion"] as! String
                let avatar = val!["avatar"] as! String
                let cedula = val!["cedula"] as! String
                let cv = val!["cv"] as! String
                let especialidad = val!["especialidad"] as! String
                let nombre = val!["nombre"] as! String

                puntaje = puntaje + campos
                let data = [ "calificacion": puntaje, "avatar": avatar,  "cedula": cedula, "cv":cv, "especialidad": especialidad, "nombre": nombre ]
                print(data)
                self.ref2.setData(data) { (err) in
                    if let err = err?.localizedDescription {
                        print("Se ha producido un error \(err)")
                    } else {
                        print("Exito al modificar los campos")
                    }
                }
            }
        }
    }
    
    @IBAction func starRagting(_ sender: UIButton) {
        let tag = sender.tag
        calif = 0
        for button in collectionStar {
            if button.tag <= tag {
                calif = button.tag
                button.setTitle("★", for: .normal)
            } else {
                button.setTitle("☆", for: .normal)
            }
        }
    }

    
    @IBAction func cerrarVentana(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
