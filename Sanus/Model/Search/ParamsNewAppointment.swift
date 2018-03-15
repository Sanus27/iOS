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
    
}
