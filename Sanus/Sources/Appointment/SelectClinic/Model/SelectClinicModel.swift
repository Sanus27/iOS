//
//  SelectClinicModel.swift
//  Sanus
//
//  Created by luis on 27/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SelectClinicModel: UIViewController {

    private var getRef:Firestore!
    public var listItems = [Hospitals]()
    
    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }

    public func showData( completionHandler: @escaping (([Hospitals]) -> Void)) {
        
        isConected()
        self.getRef = Firestore.firestore()
        self.getRef.collection("hospitales").addSnapshotListener { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                for doc in result!.documents {
                    let id = doc.documentID
                    let valDoc = doc.data()
                    let name = valDoc["nombre"] as? String
                    let address = valDoc["direccion"] as? String
                    let hospital = Hospitals( id: id, address: address, name: name )
                    self.listItems.append(hospital)
                    completionHandler( self.listItems )
                }
                
            }
        }
        
    }
    

}
