//
//  Citas.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Appointment{
    
    var id: String?
    var doctor: String?
    var date: String?
    var hour: String?
    var hospital: String?
    var user: String?
    
    init( id:String?, doctor:String?, date:String?, hour: String?, hospital:String?, user:String? ) {
        self.id = id
        self.doctor = doctor
        self.date = date
        self.hour = hour
        self.hospital = hospital
        self.user = user
    }
}
