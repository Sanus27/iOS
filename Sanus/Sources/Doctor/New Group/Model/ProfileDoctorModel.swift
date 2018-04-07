//
//  ProfileDoctorModel.swift
//  Sanus
//
//  Created by luis on 22/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileDoctorModel: UIViewController {

    private var resp: [String:Any] = [:]
    private var ref: DocumentReference!
    private var ref2: DocumentReference!
    private var uid: String?
    
    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }

    public func showData(  completionHandler: @escaping (([String:Any]) -> Void)) {
        
        isConected()
        self.uid = (Auth.auth().currentUser?.uid)!
        self.ref = Firestore.firestore().collection("doctores").document( self.uid! )
        self.ref.getDocument { (document, error) in
            if let document = document {
                let valDoctor = document.data()
                let cv = valDoctor!["cv"] as! String
                let idCard = valDoctor!["cedula"] as! String
                let speciality = valDoctor!["especialidad"] as! String
                let calif = valDoctor!["calificacion"] as! String
                let coment = valDoctor!["comentario"] as! String
                
                self.ref2 = Firestore.firestore().collection("usuarios").document( self.uid! )
                self.ref2.getDocument { (doc, error) in
                    if let doc = doc {
                        let valUser = doc.data()
                        var avatar = valUser!["avatar"] as? String
                        avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                        self.resp = [ "vacio": false, "cv": cv, "cedula": idCard, "especialidad": speciality, "calificacion": calif, "comentario": coment, "avatar": avatar!  ]
                        completionHandler( self.resp )
                    }
                }
                
            } else {
                self.resp = [ "vacio": true ]
                completionHandler( self.resp )
            }
        }
        
    }

}
