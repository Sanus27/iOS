//
//  Doctores.swift
//  Sanus
//
//  Created by Luis on 06/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Doctor {
    
    var avatar: String?
    var idCard: String?
    var cv: String?
    var specialty: String?
    var horario: String?
    var nombre: String?
    var apellido: String?
    var id: String?
    
    init( id:String?, avatar: String?, idCard: String?, cv:String?, specialty:String?, horario:String?, nombre:String?, apellido: String? ) {
        self.id = id
        self.avatar = avatar
        self.idCard = idCard
        self.cv = cv
        self.specialty = specialty
        self.horario = horario
        self.nombre = nombre
        self.apellido = apellido
    }
    
}
