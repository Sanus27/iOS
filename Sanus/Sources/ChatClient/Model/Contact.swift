//
//  Contact.swift
//  Sanus
//
//  Created by luis on 19/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Contact {
    
    public var id: String?
    public var avatar: String?
    public var autor: String?
    public var doctor: String?
    public var nombre: String?
    public var apellidos: String?
    public var estado: String?
    
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
