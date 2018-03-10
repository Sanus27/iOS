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
    
    public func getHospital() -> String? {
        idHospital = UserDefaults.standard.object(forKey: "idHospital") as? String
        return idHospital
    }
    
    public func setHospital( id:String? ){
        UserDefaults.standard.removeObject(forKey: "idHospital")
        UserDefaults.standard.set( id , forKey: "idHospital")
    }
    
}
