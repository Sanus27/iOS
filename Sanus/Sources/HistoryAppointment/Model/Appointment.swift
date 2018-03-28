//
//  Citas.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Appointment{
    
    public var id: String?
    public var doctor: String?
    public var date: String?
    public var hour: String?
    public var hospital: String?
    public var user: String?
    
    init( id:String?, doctor:String?, date:String?, hour: String?, hospital:String?, user:String? ) {
        self.id = id
        self.doctor = doctor
        self.date = date
        self.hour = hour
        self.hospital = hospital
        self.user = user
    }
}
