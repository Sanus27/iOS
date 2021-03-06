//
//  ChatModel.swift
//  Sanus
//
//  Created by luis on 27/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ChatModel: UIViewController {

    private var ref:DocumentReference!
    public var listItems = [Contact]()
    private var uid:String = ""
    
    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( getRef:Firestore, completionHandler: @escaping (([Contact]) -> Void)) {
        self.uid = (Auth.auth().currentUser?.uid)!
    
        isConected()
        getRef.collection("contactos").whereField("autor", isEqualTo: self.uid ).addSnapshotListener { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                self.listItems.removeAll()
                //self.tableData.reloadData()
                
                for doc in result!.documents {
                    let id = doc.documentID
                    let valCont = doc.data()
                    let author = valCont["autor"] as? String
                    let doctor = valCont["doctor"] as? String
                    
                    
                    self.ref = Firestore.firestore().collection("usuarios").document( doctor! )
                    self.ref.addSnapshotListener { (resp, error) in
                        if let error = error {
                            print("se ha producido un error \(error)")
                        } else {
                            
                            if let resp = resp {
                                let valUser = resp.data()
                                var avatar = valUser!["avatar"] as? String
                                let name = valUser!["nombre"] as? String
                                let lastname = valUser!["apellido"] as? String
                                let estado = valUser!["estado"] as? String
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                                let contact = Contact( id:id, avatar:avatar!, autor:author!, doctor:doctor!, nombre:name!, apellidos: lastname!, estado:estado! )
                                self.listItems.append(contact)
                                completionHandler( self.listItems )
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
    }

    

}
