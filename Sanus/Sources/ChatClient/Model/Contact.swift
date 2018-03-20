//
//  Contact.swift
//  Sanus
//
//  Created by luis on 19/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Contact {
    
    var id: String?
    var avatar: String?
    var autor: String?
    var doctor: String?
    var nombre: String?
    var apellidos: String?
    var estado: String?
    
    init( id: String?, avatar: String?, autor: String?, doctor: String?, nombre: String?, apellidos: String?, estado: String? ) {
        self.id = id
        self.avatar = avatar
        self.autor = autor
        self.doctor = doctor
        self.nombre = nombre
        self.apellidos = apellidos
        self.estado = estado
    }
    
}
