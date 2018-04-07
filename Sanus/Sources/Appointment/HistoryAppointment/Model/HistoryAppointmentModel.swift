//
//  HistoryAppointmentModel.swift
//  Sanus
//
//  Created by luis on 27/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class HistoryAppointmentModel: UIViewController {

    private var ref:DocumentReference!
    private var getRef:Firestore!
    public var listItems = [Appointment]()
    

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( completionHandler: @escaping (([Appointment]) -> Void)) {
        
        isConected()
        getRef = Firestore.firestore()
        getRef.collection("citas").addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listItems.removeAll()
                
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let doctor = val["doctor"] as? String
                    let date = val["fecha"] as? String
                    let hour = val["hora"] as? String
                    let user = val["usuario"] as? String
                    let hospital = val["hospital"] as? String
                    //var avatar = val["avatar"] as? String
                    //avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                    let appointment = Appointment(id: id, doctor: doctor, date: date, hour: hour, hospital: hospital, user: user)
                    self.listItems.append(appointment)
                    completionHandler( self.listItems )
                }
                
            }
        }
        
    }
    

}
