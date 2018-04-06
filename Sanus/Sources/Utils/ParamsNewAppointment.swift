//
//  ParamsAppointment.swift
//  Sanus
//
//  Created by luis on 09/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class ParamsNewAppointment {
    
    public var idHospital:String? = ""
    public var idDoctor:String? = ""
    public var idCalendar:String? = ""
    public var idUser:String? = ""
    public var idTypeUser:String? = ""
    
    public func getHospital() -> String? {
        idHospital = UserDefaults.standard.object(forKey: "idHospital") as? String
        return idHospital
    }
    
    public func setHospital( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idHospital")
        UserDefaults.standard.set( id , forKey: "idHospital")
    }
    
    public func getDoctor() -> String? {
        idDoctor = UserDefaults.standard.object(forKey: "idDoctor") as? String
        return idDoctor
    }
    
    public func setDoctor( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idDoctor")
        UserDefaults.standard.set( id , forKey: "idDoctor")
    }
    
    public func getCalendar() -> String? {
        idCalendar = UserDefaults.standard.object(forKey: "idCalendar") as? String
        return idCalendar
    }
    
    public func setCalendar( date:String? ){
        UserDefaults.standard.removeObject(forKey: "idCalendar")
        UserDefaults.standard.set( date , forKey: "idCalendar")
    }
    
    public func getID() -> String? {
        idUser = UserDefaults.standard.object(forKey: "idUser") as? String
        return idUser
    }
    
    public func setID( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idUser")
        UserDefaults.standard.set( id , forKey: "idUser")
    }
    
    public func getTypeUser() -> String? {
        idTypeUser = UserDefaults.standard.object(forKey: "idTypeUser") as? String
        return idTypeUser
    }
    
    public func setTypeUser( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idTypeUser")
        UserDefaults.standard.set( id , forKey: "idTypeUser")
    }
    
    
    public func removeID(){
        UserDefaults.standard.removeObject(forKey: "idUser")
    }
    
    public func removeTypeUser() {
        UserDefaults.standard.removeObject(forKey: "idTypeUser")
    }
}
