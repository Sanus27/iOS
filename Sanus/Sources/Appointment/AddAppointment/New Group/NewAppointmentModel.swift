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
    private var idDoctor:String?
    private var idHospital:String?
    private var idUser:String?
    private var hour:String?
    private var dateApp:String?
    private var idRegister:String?
    private var getRef:DocumentReference!
    
    public func newAppintment( completionHandler: @escaping ((String) -> Void)) {
        self.idDoctor = self.params.getDoctor()!
        self.idHospital = self.params.getHospital()!
        self.idUser = self.params.getID()!
        self.hour = ""
        self.dateApp = self.params.getCalendar()!
        
        self.ref = Firestore.firestore().collection("citas").addDocument(data: [
            "doctor": self.idDoctor!,
            "usuario": self.idUser!,
            "hospital": self.idHospital!,
            "fecha": self.dateApp!,
            "hora": self.hour!
        ]) { err in
            
            if err != nil {
                completionHandler("Se ha producido un error, intentelo nuevamente")
            } else {
                self.params.setIdRegister(id: self.ref.documentID )
                completionHandler(self.ref.documentID)
            }
            
        }
        
    }
    
    
    public func editAppintment( completionHandler: @escaping ((String) -> Void)) {
        self.hour = self.params.getHour()!
        self.idRegister = self.params.getIdRegister()!
        
        
        self.ref = Firestore.firestore().collection("citas").document( self.idRegister! )
        self.ref.updateData([
            "hora": self.hour!
        ]) { err in
            
            if err != nil {
                completionHandler("Se ha producido un error, intentelo nuevamente")
            } else {
                completionHandler("success")
            }
            
        }
        
    }
    
    
    public func deleteAppintment( completionHandler: @escaping ((String) -> Void)) {
    
        if self.params.getIdRegister() != nil {
            self.idRegister = self.params.getIdRegister()!
            self.ref = Firestore.firestore().collection("citas").document( self.idRegister! )
            self.ref.delete() { err in
                
                if err != nil {
                    completionHandler("Se ha producido un error, intentelo nuevamente")
                } else {
                    completionHandler("success")
                }
                
            }
        } else {
            completionHandler("success")
        }
        
        
    }
    
    
    public func addAppointmentReserved( completionHandler: @escaping ((String) -> Void)) {
        
        
        self.getRef = Firestore.firestore().collection("citas-ocupadas").document( self.params.getDoctor()! ).collection("fecha").addDocument(data: [
            "fecha": self.params.getCalendar()!
        ]) { err in
            
            if err != nil {
                completionHandler("Se ha producido un error, intentelo nuevamente")
            } else {
               
                self.params.setRegisterDate(id: self.getRef.documentID )
                
                self.ref = Firestore.firestore().collection("citas-ocupadas").document( self.params.getDoctor()! ).collection("hora").addDocument(data: [
                    "hora": self.params.getHour()!
                ]) { err in
                    
                    if err != nil {
                        completionHandler("Se ha producido un error, intentelo nuevamente")
                    } else {
                        self.params.setRegisterHour(id: self.ref.documentID )
                        completionHandler(self.ref.documentID)
                    }
                    
                }
                
                
            }
            
        }


        
    }
    
    
    
    public func deleteAppintmentReserved( completionHandler: @escaping ((String) -> Void)) {
        
        
            self.ref = Firestore.firestore().collection("citas-ocupadas").document( self.params.getDoctor()! ).collection("fecha").document( self.params.getRegisterDate()! )
            self.ref.delete() { err in
                
                if err != nil {
                    completionHandler("Se ha producido un error, intentelo nuevamente")
                } else {
                    
                    self.ref = Firestore.firestore().collection("citas-ocupadas").document( self.params.getDoctor()! ).collection("hora").document( self.params.getRegisterHour()! )
                    self.ref.delete() { err in
                        
                        if err != nil {
                            completionHandler("Se ha producido un error, intentelo nuevamente")
                        } else {
                            completionHandler("success")
                        }
                        
                    }
                    
                }
                
            }
       
        
    }
    
    

    
  
    
}
