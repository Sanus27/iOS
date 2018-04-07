//
//  SettingProfileModel.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SettingProfileModel: UIViewController {
    
    private var ref:DocumentReference!
    private var success: [String:Any] = [:]
    private var uid: String?
    

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func dataUser( this:UIViewController, completionHandler: @escaping (([String:Any]) -> Void)) {
        
        isConected()
        let uid = Auth.auth().currentUser?.uid
        self.ref = Firestore.firestore().collection("usuarios").document( uid! )
        self.ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let lastname = val!["apellido"] as! String
                let name = val!["nombre"] as! String
                var avatar = val!["avatar"] as? String
                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                let sex = val!["sexo"] as? String
                let year = val!["edad"] as? String

                if avatar != nil {
                    Storage.storage().reference(forURL: avatar!).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            self.success = [ "display-error": true, "error": error ]
                            completionHandler( self.success )
                        } else {
                            self.success = [ "display-error": false, "apellido": lastname, "nombre": name, "avatar": avatar!, "sex": sex!, "year": year! ]
                            completionHandler( self.success )
                        }
                    })
                } else {
                    self.success = [ "display-error": false, "apellido": lastname, "nombre": name, "avatar": "default", "sex": sex!, "year": year! ]
                    completionHandler( self.success )
                }



            }
        }

    }


}
