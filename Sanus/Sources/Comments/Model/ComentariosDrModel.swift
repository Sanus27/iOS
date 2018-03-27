//
//  ComentariosDrModel.swift
//  Sanus
//
//  Created by luis on 26/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ComentariosDrModel: UIViewController {

    private var ref:DocumentReference!
    public var listComents = [Comments]()
    public var resp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    public func showData( getRef:Firestore, idDoctor: String, completionHandler: @escaping (([Comments]) -> Void)) {
        
        getRef.collection("comentarios").whereField( "doctor", isEqualTo: idDoctor ).order(by: "hora", descending: true).addSnapshotListener { (result , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listComents.removeAll()
                for document in result!.documents {
                    let valComen = document.data()
                    let rating = valComen["calificacion"] as? String
                    let user = valComen["usuario"] as? String
                    let date = valComen["fecha"] as? String
                    let comment = valComen["comentario"] as? String
                    
                    self.ref = Firestore.firestore().collection("usuarios").document( user! )
                    self.ref.addSnapshotListener { (resp, error) in
                        if let error = error {
                            print("se ha producido un error \(error)")
                        } else {
                            
                            if let resp = resp {
                                let valUser = resp.data()
                                var avatar = valUser!["avatar"] as? String
                                let nombre = valUser!["nombre"] as? String
                                let apellido = valUser!["apellido"] as? String
                                let fullname = nombre! + " " + apellido!
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                                
                                let comments = Comments( comment: comment, doctor: fullname, date: date, user: user, avatar: avatar, rating: rating )
                                self.listComents.append(comments)
                                completionHandler( self.listComents )
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
            }
        }
        
    }
    
    public func newComent( uid:String, id:String, coment:String, fech:String, cal:String, hours:String, completionHandler: @escaping ((String) -> Void)) {
        
        self.ref = Firestore.firestore().collection("comentarios").addDocument(data: [
            "usuario": uid,
            "doctor": id,
            "comentario": coment,
            "fecha": fech,
            "calificacion": cal,
            "hora": hours
        ]) { err in
            if let err = err {
                let resp = err as! String
                self.resp = resp
                completionHandler( self.resp )
            } else {
                let resp = "success"
                self.resp = resp
                completionHandler( self.resp )
            }
        }
        
    }
    
    
    public func ratings( data:String, id:String, completionHandler: @escaping ((String) -> Void)) {
        
        ref = Firestore.firestore().collection("doctores").document( id )
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let puntaje = val!["calificacion"] as! String
                let comment = val!["comentario"] as! String
                let cedula = val!["cedula"] as! String
                let cv = val!["cv"] as! String
                let especialidad = val!["especialidad"] as! String
                let hospital = val!["hospital"] as! String
                let cal = Int(puntaje)! + Int(data)!
                let com = Int(comment)! + 1
                let data = [ "calificacion": String(cal), "cedula": cedula, "cv":cv, "especialidad": especialidad, "comentario": String(com), "hospital":hospital ]
                self.ref.setData(data) { (err) in
                    if let err = err?.localizedDescription {
                        self.resp = err
                        completionHandler( self.resp )
                    } else {
                        let resp = "success"
                        self.resp = resp
                        completionHandler( self.resp )
                    }
                }
            }
        }
        
    }
    
    
    public func isDoctor( completionHandler: @escaping ((String) -> Void)) {
        
        let id = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( id )
        ref.getDocument { (document, error) in
            if let document = document {
                let exist = document.data()
                let typeData = exist!["tipo"] as? String
                completionHandler( typeData! )
            }
        }
        
    }
    

    
}
