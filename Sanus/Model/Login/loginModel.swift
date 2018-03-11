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
    public let result = SetAndGets()
    
    //VALID IS THE USER IS COMPLE OR NOT
    public func isLoggedIsCompleateLogin( this: UIViewController ) -> Void {
        let id = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( id )
        ref.getDocument { (document, error) in
            
            if let document = document {
                let exist = document.data()
                    if exist != nil {
                        this.performSegue(withIdentifier: "login", sender: this )
                    } else {
                        this.performSegue(withIdentifier: "completeUser", sender: this )
                    }
            }
            
            
        }
    }
    
    //LOGIN
    public func login( this: UIViewController, txtEmail: String, txtPassword: String ) -> Void {
        
        
        Auth.auth().signIn( withEmail: txtEmail, password: txtPassword ) { ( user, error ) in
            if user != nil {
                print(user!)
            } else {
                if let error = error?.localizedDescription {
                    print(error)
                }
            }
            
        }
        
        
    }
    
    
    
}





class SetAndGets {
    
    public var resp: String = ""
    public func getData() -> String {
        return self.resp
    }
    
    public func setData( newData: String ){
        self.resp = newData
    }
    
}




