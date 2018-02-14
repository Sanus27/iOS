//
//  Usuarios.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Usuarios{
    
    var edad: String?
    var estado: Int?
    var nombre: String?
    var apellido: String?
    var tipo: String?
    
    init( edad: String?, estado: Int?, nombre: String?, apellido: String?, tipo: String? ) {
        self.edad = edad
        self.estado = estado
        self.nombre = nombre
        self.apellido = apellido
        self.tipo = tipo
    }
    
}
