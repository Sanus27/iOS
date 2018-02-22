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

    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtComentario: UITextView!
    var nuevoComentario:String!
    var id = ""
    var uid = ""
    var ref:DocumentReference!
    var getRef: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = nuevoComentario
        getRef = Firestore.firestore()
        uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document(uid)
        comprobar();
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
        load.startAnimating()
        let date = Date()
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.timeStyle = .none
        let fecha = formater.string(from: date)
        
        
        ref = Firestore.firestore().collection("comentarios").addDocument(data: [
            "usuario": uid,
            "doctor": id,
            "comentario": txtComentario!.text,
            "facha": fecha
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                self.load.stopAnimating()
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                self.load.stopAnimating()
            }
        }

    }
    

}
