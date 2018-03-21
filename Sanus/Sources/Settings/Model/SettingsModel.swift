//
//  SettingsModel.swift
//  Sanus
//
//  Created by luis on 13/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsModel: UIViewController {

    private var ref:DocumentReference!
    private var uid:String = ""
    private var success: [String:Any] = [:]
    private let url:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func showData( uid: String ,completionHandler: @escaping (([String:Any]) -> Void)) {
        ref = Firestore.firestore().collection("usuarios").document( uid )
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                var avatar = val!["avatar"] as? String
                let name = val!["nombre"] as! String
                let lastname = val!["apellido"] as! String
                let state = val!["estado"] as! String
                let fullname: String = name + " " + lastname
                
                if avatar != nil {
                    avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                    Storage.storage().reference(forURL: avatar!).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            self.success = [ "warning": true ]
                            print("fallo al traer imagenes", error)
                            completionHandler( self.success )
                        } else {
                            self.success = [ "warning": false, "defaults": false, "avatar": data!, "fullname": fullname, "estado": state ]
                            
                            completionHandler( self.success )
                        }
                    })
                    
                } else {
                    self.success = [ "warning": false, "defaults": true ]
                    completionHandler( self.success )
                }
                
            } else {
                print("documento no existe")
            }
        }
    }


}
