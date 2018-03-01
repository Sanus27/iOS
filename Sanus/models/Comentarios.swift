//
//  Comentarios.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Comentarios{
    
    //var id: String?
    var comentario: String?
    var doctor: String?
    var fecha: String?
    var usuario: String?
    var avatar: String?
    var calificacion: String?
    
    init( comentario: String?, doctor: String?, fecha: String?, usuario: String?, avatar: String?, calificacion: String? ) {
        self.comentario = comentario
        self.doctor = doctor
        self.fecha = fecha
        self.usuario = usuario
        self.avatar = avatar
        self.calificacion = calificacion
    }
    
}
