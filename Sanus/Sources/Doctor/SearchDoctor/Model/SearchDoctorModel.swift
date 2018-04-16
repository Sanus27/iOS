//
//  SearchDoctorModel.swift
//  Sanus
//
//  Created by luis on 26/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SearchDoctorModel: UIViewController {

    private var ref:DocumentReference!
    public var listItem = [Doctor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( getRef:Firestore, completionHandler: @escaping (([Doctor]) -> Void)) {
        isConected()
        getRef.collection("doctores").getDocuments { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                for doc in result!.documents {
                    let id = doc.documentID
                    let valDoc = doc.data()
                    let specialty = valDoc["especialidad"] as? String
                    
                    
                    self.ref = Firestore.firestore().collection("usuarios").document(id)
                    self.ref.getDocument { (resp, error) in
                        if let error = error {
                            print("se ha producido un error \(error)")
                        } else {
                            
                            if let resp = resp {
                                let valUser = resp.data()
                                var avatar:String? = valUser!["avatar"] as? String
                                let name = valUser!["nombre"] as? String
                                let lastname = valUser!["apellido"] as? String
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                                let doctor = Doctor( id:id, avatar: avatar, idCard: nil, cv: nil, specialty: specialty, horario: nil, nombre: name, apellido: lastname)
                                self.listItem.append( doctor )
                                completionHandler( self.listItem )
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
    
}
