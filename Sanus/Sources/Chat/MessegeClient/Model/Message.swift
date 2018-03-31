//
//  Message.swift
//  Sanus
//
//  Created by luis on 18/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Message {
    
    public var id: String?
    public var autor: String?
    public var doctor: String?
    public var usuario: String?
    public var hora: String?
    public var fecha: String?
    public var mensaje: String?
    
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
