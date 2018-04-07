//
//  PerfilDoctorModel.swift
//  Sanus
//
//  Created by luis on 26/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PerfilDoctorModel: UIViewController {

    private var ref: DocumentReference!
    private var ref2: DocumentReference!
    private var resp: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( uid:String, completionHandler: @escaping (([String:Any]) -> Void)) {
        isConected()
        ref = Firestore.firestore().collection("doctores").document( uid )
        ref2 = Firestore.firestore().collection("usuarios").document( uid )
        ref.getDocument { (document, error) in
            
            
            self.ref2.getDocument { (docs, err) in
                if let docs = docs {
                    let valUser = docs.data()
                    let name = valUser!["nombre"] as! String
                    let lastname = valUser!["apellido"] as! String
                    var avatar = valUser!["avatar"] as? String
                    avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!

            
                    if let document = document {
                        let val = document.data()
                        let cv = val!["cv"] as! String
                        let specialty = val!["especialidad"] as! String
                        let idCard = val!["cedula"] as! String
                        var calif = val!["calificacion"] as! String
                        let coment = val!["comentario"] as! String
                        
                       
                        if calif != "0" {
                            let op:Int = Int(calif)! / Int(coment)!
                            calif = String(op)
                        }
                        
                        self.resp = [ "name":name, "lastname":lastname, "avatar":avatar!, "cv":cv, "especialidad":specialty, "cedula":idCard, "calificacion":calif ]
                        completionHandler( self.resp )
                            
                        
                        
                    }
                        
                }
                    
            }
            
        }
    }


}
