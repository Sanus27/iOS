//
//  loginModel.swift
//  Sanus
//
//  Created by luis on 10/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginModel {
    
    private var ref: DocumentReference!
    private var resp:String = ""
    
    public func isLoggedIsCompleateLogin( this: UIViewController ) -> Void {
        let id = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( id )
        ref.getDocument { (document, error) in

            if let document = document {
                
                let exist = document.data()
                if exist != nil {
                    self.chageSatateUser( state:"1" )
                    let typeData = exist!["tipo"] as? String
                    if typeData! == "Medico" {
                        this.performSegue(withIdentifier: "doctor", sender: this )
                    }
                    if typeData! == "Paciente" {
                        this.performSegue(withIdentifier: "login", sender: this )
                    }
                } else {
                    this.performSegue(withIdentifier: "completeUser", sender: this )
                }
                
            }


        }
    }

    
    public func startLogin(txtEmail: String, txtPassword: String, completionHandler: @escaping ((String) -> Void)) {
        Auth.auth().signIn( withEmail: txtEmail, password: txtPassword ) { ( user, error ) in
            if user != nil {
                self.resp = "success"
                completionHandler( self.resp )
            } else {
                if let error = error?.localizedDescription {
                    self.resp = error
                    completionHandler( self.resp )
                }
            }
        }
    }
    
    public func chageSatateUser( state:String? ){
        
        let uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( uid )
        ref.getDocument { (document, error) in
            if let document = document {
                let exist = document.data()
                let name = exist!["nombre"] as? String
                let lastname = exist!["apellido"] as? String
                let avatar = exist!["avatar"] as? String
                let year = exist!["edad"] as? String
                let sex = exist!["sexo"] as? String
                let typeUsr = exist!["tipo"] as? String
                let data = [ "nombre":name!, "apellido":lastname!, "avatar":avatar!, "edad":year!, "sexo":sex!, "tipo":typeUsr!, "estado": state! ]
                self.ref.setData(data) { (err) in
                    if let err = err?.localizedDescription {
                        print("Se ha producido un error \(err)")
                    } else {
                        print("Exito al modificar los datos")
                    }
                }
            }
        }
        
    }
    
    
    
}
