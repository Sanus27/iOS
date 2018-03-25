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
    private var uid: String?
    private var ref: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = Auth.auth().currentUser?.uid
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
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let storage = Storage.storage().reference()
        let directorio = storage.child("avatar/\(self.uid!)")
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
    
    public func completeUser( data:[String:Any], id: String ,completionHandler: @escaping ((String) -> Void)) {
        self.ref = Firestore.firestore().collection("usuarios").document(id)
        self.ref.setData(data) { (error) in
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
