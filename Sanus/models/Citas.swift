//
//  Citas.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Citas{
    
    var id: String?
    var doctor: String?
    var fecha: String?
    var hospital: String?
    var usuario: String?
    
    init( id:String?, doctor:String?, fecha:String?, hospital:String?, usuario:String? ) {
        self.id = id
        self.doctor = doctor
        self.fecha = fecha
        self.hospital = hospital
        self.usuario = usuario
    }
}
