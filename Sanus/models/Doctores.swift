//
//  Doctores.swift
//  Sanus
//
//  Created by Luis on 06/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Doctores {
    
    var avatar: String?
    var cedula: String?
    var cv: String?
    var especialidad: String?
    var horario: String?
    var nombre: String?
    var apellido: String?
    var id: String?
    
    init( id:String?, avatar: String?, cedula: String?, cv:String?, especialidad:String?, horario:String?, nombre:String?, apellido: String? ) {
        self.id = id
        self.avatar = avatar
        self.cedula = cedula
        self.cv = cv
        self.especialidad = especialidad
        self.horario = horario
        self.nombre = nombre
        self.apellido = apellido
    }
    
}
