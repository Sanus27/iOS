//
//  MessegeClientModel.swift
//  Sanus
//
//  Created by luis on 27/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class MessegeClientModel: UIViewController {

    private var ref:DocumentReference!
    private var resp: Bool = false
    private var getRef:Firestore!
    private let modelC = ComentariosDrModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRef = Firestore.firestore()
    }

    
    public func showInfoMessage( idDoctor:String, completionHandler: @escaping ((String) -> Void)) {
        
        ref = Firestore.firestore().collection("usuarios").document( idDoctor )
        ref.addSnapshotListener { (document, error) in
            if let document = document {
                let val = document.data()
                let name = val!["nombre"] as! String
                completionHandler( name )
            }
        }
        
    }
    
    
    public func verifyIsExistContact( getRef:Firestore, idAuthor:String, idDoctor:String, completionHandler: @escaping ( (Bool) -> Void)) {
        
        getRef.collection("contactos").whereField("autor", isEqualTo: idAuthor ).whereField("doctor", isEqualTo: idDoctor ).addSnapshotListener { (result, error) in
            if result!.documents.count != 0 {
                self.resp = true
                completionHandler( self.resp )
            } else {
                self.resp = false
                completionHandler( self.resp )
            }
        }
        
    }
    
    public func addContact( idDoctor:String?, completionHandler: @escaping ((String) -> Void)) {
        
        let uid = (Auth.auth().currentUser?.uid)!
        self.ref = Firestore.firestore().collection("contactos").addDocument(data: [
            "autor": uid,
            "doctor": idDoctor!,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completionHandler( "error" )
            } else {
                completionHandler( "Success" )
            }
        }
        
    }
    
    
    public func addMsn( getRef:Firestore!, autor:String, doctor:String, fecha:String, hora:String, mensaje:String, usuario:String, completionHandler: @escaping ((String) -> Void)) {
        
        self.ref = Firestore.firestore().collection("mensajes").addDocument(data: [
            "autor": autor,
            "doctor": doctor,
            "fecha": fecha,
            "hora": hora,
            "mensaje": mensaje,
            "usuario": usuario
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completionHandler( "error" )
            } else {
                
                self.verifyIsExistContact( getRef:getRef, idAuthor:autor, idDoctor:doctor, completionHandler:  { result in
            
                    if !result {
                        
                        self.modelC.isDoctor( completionHandler:  { result in
     
                            if result == "Paciente" {
                                self.addContact(idDoctor:doctor, completionHandler: { response in
                                    completionHandler( "Success" )
                                })
                            } else {
                                completionHandler( "Success" )
                            }
                            
                        })
                        
                    } else {
                        completionHandler( "Success" )
                    }
                })
                
                
            }
        }
        
        
    }
    

}
