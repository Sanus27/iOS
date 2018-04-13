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
    private let user = ParamsNewAppointment()
    private var idUser:String?

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( completionHandler: @escaping (([Appointment]) -> Void)) {
        
        isConected()
        let usr = self.user.getTypeUser()!
        var condition:String?
        if usr == "Medico" {
            condition = "doctor"
        } else {
            condition = "usuario"
        }
        
        self.idUser = self.user.getID()!
        getRef = Firestore.firestore()
        getRef.collection("citas").whereField( condition! , isEqualTo: self.idUser! ).addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listItems.removeAll()
                
                for document in resp!.documents {
                    let id = document.documentID
                    let valAppoint = document.data()
                    let docAppint = valAppoint["doctor"] as? String
                    let date = valAppoint["fecha"] as? String
                    let hour = valAppoint["hora"] as? String
                    let idUser = valAppoint["usuario"] as? String
                    let idHospital = valAppoint["hospital"] as? String
                    
                    self.ref = Firestore.firestore().collection("usuarios").document( docAppint! )
                    self.ref.addSnapshotListener { (res,err) in
                        if let err = err {
                            print("hay un error en firebase", err)
                        } else {
                            if let res = res {
                                let valDoctor = res.data()
                                let name = valDoctor!["nombre"] as? String
                                let apellido = valDoctor!["apellido"] as? String
                                var avatar = valDoctor!["avatar"] as? String
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                                let doctor = name! + " " + apellido!
                                
                                    self.getRef.collection("hospitales").document( idHospital! ).addSnapshotListener { (result , erro) in
                                        if let erro = erro {
                                            print("hay un error en firebase", erro)
                                        } else {
                                            if let result = result {
                                                let valHospital = result.data()
                                                let hospital = valHospital!["nombre"] as? String
                                                let appointment = Appointment( id: id, doctor: doctor, date: date, hour: hour, hospital: hospital, user: idUser, avatar:avatar )
                                                self.listItems.append(appointment)
                                                completionHandler( self.listItems )
                                            }
                                            
                                        }
                                    }
                                
                            }
                        }
                    }
                    
                    
                    
                   
                    
                }
                
            }
        }
        
    }
    

}
