//
//  ParamsAppointment.swift
//  Sanus
//
//  Created by luis on 09/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class ParamsNewAppointment {
        
    public func getHospital() -> String? {
        return UserDefaults.standard.object(forKey: "idHospital") as? String
    }
    
    public func setHospital( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idHospital")
        UserDefaults.standard.set( id , forKey: "idHospital")
    }
    
    public func getHour() -> String? {
        return UserDefaults.standard.object(forKey: "idHour") as? String
    }
    
    public func setHour( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idHour")
        UserDefaults.standard.set( id , forKey: "idHour")
    }
    
    public func getDoctor() -> String? {
        return UserDefaults.standard.object(forKey: "idDoctor") as? String
    }
    
    public func setDoctor( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idDoctor")
        UserDefaults.standard.set( id , forKey: "idDoctor")
    }
    
    public func getCalendar() -> String? {
        return UserDefaults.standard.object(forKey: "idCalendar") as? String
    }
    
    public func setCalendar( date:String? ){
        UserDefaults.standard.removeObject(forKey: "idCalendar")
        UserDefaults.standard.set( date , forKey: "idCalendar")
    }
    
    public func getID() -> String? {
        return UserDefaults.standard.object(forKey: "idUser") as? String
    }
    
    public func setID( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idUser")
        UserDefaults.standard.set( id , forKey: "idUser")
    }
    
    public func getTypeUser() -> String? {
        return UserDefaults.standard.object(forKey: "idTypeUser") as? String
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
