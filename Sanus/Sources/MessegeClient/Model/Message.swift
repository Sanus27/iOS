//
//  Message.swift
//  Sanus
//
//  Created by luis on 18/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Message {
    
    var id: String?
    var autor: String?
    var doctor: String?
    var usuario: String?
    var hora: String?
    var fecha: String?
    var mensaje: String?
    
    init( id: String?, autor: String?, doctor: String?, usuario: String?, hora: String?, fecha: String?, mensaje: String? ) {
        self.id = id
        self.autor = autor
        self.doctor = doctor
        self.usuario = usuario
        self.hora = hora
        self.fecha = fecha
        self.mensaje = mensaje
    }
    
}
