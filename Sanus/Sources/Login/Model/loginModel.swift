//
//  loginModel.swift
//  Sanus
//
//  Created by luis on 10/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
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
                    let typeData = exist!["tipo"] as? String
                    if typeData! == "Medico" {
                        self.chageSatateUser( state:"1" )
                        this.performSegue(withIdentifier: "doctor", sender: this )
                    }
                    if typeData! == "Paciente" {
                        self.chageSatateUser( state:"1" )
                        this.performSegue(withIdentifier: "login", sender: this )
                    }
                    if typeData! == "Admin" {
                        let alerts = Alerts()
                        alerts.alertSimple(this: this, titileAlert: "Acceso restringido", bodyAlert: "El acceso al sistema es unicamente es para pacientes y doctores", actionAlert: nil )
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
    
    public func loginFacebook( this:UIViewController, completionHandler: @escaping ((String) -> Void)) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: this) { (resp, error) in
            if error != nil {
                completionHandler( "errro de permisos" )
                return
            } else {
                print(resp!.token.tokenString)
                let accessToken = FBSDKAccessToken.current()
                guard let accessTokenString = accessToken?.tokenString else { return }
                let credentials = FacebookAuthProvider.credential( withAccessToken: accessTokenString )
                
                Auth.auth().signIn(with: credentials, completion: { (user, err) in
                    if err != nil {
                        completionHandler( "error" )
                        print("se ha producido un error", err!)
                        return
                    } else {
                        completionHandler( "success" )
                        print("informacion del usuario: ", user!)
                    }
                })
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
