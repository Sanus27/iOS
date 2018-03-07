//
//  Alerts.swift
//  Sanus
//
//  Created by luis on 06/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    
    public var titileAlert: String?
    public var bodyAlert: String?
    
    init( titileAlert: String?, bodyAlert: String? ) {
        self.titileAlert = titileAlert
        self.bodyAlert = bodyAlert
    }
    
    public func alertSimple(){
        let alert = UIAlertController(title: self.titileAlert, message: self.bodyAlert, preferredStyle: .alert);
        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
        alert.addAction(acept);
    }
    
    public func alertAvanced( segueReturn:String ){
        let alerta = UIAlertController(title: "Correo no esta registrado", message: "¿Desea crear una cuenta?", preferredStyle: .alert);
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            //self.performSegue(withIdentifier: segueReturn, sender: self);
        }))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil ))
    }
    
}
