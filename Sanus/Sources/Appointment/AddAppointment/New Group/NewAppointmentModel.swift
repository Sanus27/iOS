//
//  Appointment.swift
//  Sanus
//
//  Created by luis on 11/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation
import Firebase

class NewAppointmentModel {
    
    private let params = ParamsNewAppointment()
    private var ref:DocumentReference!
    private var getRef:Firestore!
    private let idDoctor:String?
    private let idHospital:String?
    private let idUser:String?
    private let hour:String?
    private let dateApp:String?
    
    init() {
        self.idDoctor = self.params.getDoctor()!
        self.idHospital = self.params.getHospital()!
        self.idUser = self.params.getID()!
        self.hour = self.params.getHour()!
        self.dateApp = self.params.getCalendar()!
        self.getRef = Firestore.firestore()
    }
    
    
    public func newAppintment( completionHandler: @escaping ((String) -> Void)) {
      
        getRef.collection("citas").whereField("doctor", isEqualTo: self.idDoctor! ).whereField("usuario", isEqualTo: self.idUser! ).whereField("hospital", isEqualTo: self.idHospital! ).whereField("fecha", isEqualTo: self.dateApp! ).whereField("hora", isEqualTo: self.hour! ).addSnapshotListener { (result, error) in
            
            
            if result!.documents.count == 0 {
                
                self.ref = Firestore.firestore().collection("citas").addDocument(data: [
                    "doctor": self.idDoctor!,
                    "usuario": self.idUser!,
                    "hospital": self.idHospital!,
                    "fecha": self.dateApp!,
                    "hora": self.hour!
                ]) { err in
                    
                    if err == nil {
                        completionHandler("Se ha producido un error, intentelo nuevamente")
                    } else {
                        completionHandler("success")
                    }
                    
                }
                
            } else {
                completionHandler("Ya existe la cita, intentalo con otra")
            }
            
        }
        
        
        
    }
    
   
    
    
  
    
}
