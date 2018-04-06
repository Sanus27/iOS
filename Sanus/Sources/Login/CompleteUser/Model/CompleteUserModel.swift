//
//  CompleteUserModel.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class CompleteUserModel: UIViewController {
    
    private var resp: String?
    private let alert = Alerts()
    private var uid: String = ""
    private var ref: DocumentReference!
    private let user = ParamsNewAppointment()
    private var campos: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func getAlert( this: UIViewController, completionHandler: @escaping ((String) -> Void)) {
        Auth.auth().addStateDidChangeListener{ ( auth, user ) in
            if user != nil {
                self.resp = "success"
                completionHandler( self.resp! )
            }
        }
    }
    
    public func uploadPicture( imagen:UIImage, completionHandler: @escaping ((String) -> Void)) {
        self.uid = self.user.getID()!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let storage = Storage.storage().reference()
        let directorio = storage.child("avatar/\(String(describing:  self.uid ))")
        directorio.putData(UIImagePNGRepresentation(imagen)!, metadata: metaData) { (data, error) in
            if error == nil {
                self.resp = "success"
                completionHandler( self.resp! )
            } else {
                if let error = error?.localizedDescription {
                    self.resp = error
                    completionHandler( self.resp! )
                }
            }
        }
    }
    
    public func completeUser( data:[String:Any] ,completionHandler: @escaping ((String) -> Void)) {

        self.uid = self.user.getID()!
        if data["avatar"] as! String == "1" {
            campos = [ "avatar": self.uid , "nombre": data["nombre"]!, "apellido": data["apellido"]!, "edad": data["edad"] ?? "", "sexo": data["sexo"]!, "tipo": "Paciente", "estado": "1" ]
        } else {
            campos = [ "avatar": data["avatar"]!, "nombre": data["nombre"]!, "apellido": data["apellido"]!, "edad": data["edad"] ?? "", "sexo": data["sexo"]!, "tipo": "Paciente", "estado": "1" ]
        }
    
        self.ref = Firestore.firestore().collection("usuarios").document( self.uid )
        self.ref.setData(campos) { (error) in
            if let error = error?.localizedDescription {
                self.resp = error
                completionHandler( self.resp! )
            } else {
                self.resp = "success"
                completionHandler( self.resp! )
            }
        }
        
    }
    
    
}
