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
    var getRef: Firestore!
    var calif = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = nuevoComentario
        btnComentarEditing.isEnabled = false
        getRef = Firestore.firestore()
        uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document(uid)
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
            
            ref = Firestore.firestore().collection("comentarios").addDocument(data: [
                "usuario": uid,
                "doctor": id,
                "comentario": txtComentario.text!,
                "fecha": fecha,
                "calificacion": calif
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.load.stopAnimating()
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                    self.load.stopAnimating()
                    self.txtComentario.text = ""
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
    
    
    @IBAction func starRagting(_ sender: UIButton) {
        let tag = sender.tag
        calif = 0
        for button in collectionStar {
            if button.tag <= tag {
                //seleccionado
                calif = button.tag
                print("contador de selecionadas \(calif)")
                button.setTitle("★", for: .normal)
            } else {
                //no selecionado
                button.setTitle("☆", for: .normal)
            }
        }
    }
    
    
    
    
    

}
