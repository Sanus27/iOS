//
//  Doctores.swift
//  Sanus
//
//  Created by Luis on 06/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Doctor {
    
    public var avatar: String?
    public var idCard: String?
    public var cv: String?
    public var specialty: String?
    public var horario: String?
    public var nombre: String?
    public var apellido: String?
    public var id: String?
    
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
