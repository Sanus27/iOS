//
//  Comentarios.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Comentarios{
    
    var comentario: String?
    var doctor: String?
    var fecha: String?
    var usuario: String?
    
    init( comentario: String?, doctor: String?, fecha: String?, usuario: String? ) {
        self.comentario = comentario
        self.doctor = doctor
        self.fecha = fecha
        self.usuario = usuario
    }
    
}
