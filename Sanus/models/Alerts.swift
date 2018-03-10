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
    
    public func alertSimple() -> UIAlertController {
        let alert = UIAlertController(title: self.titileAlert, message: self.bodyAlert, preferredStyle: .alert);
        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
        alert.addAction(acept);
        return alert
    }
    
    public func alertAvanced(){
        let alerta = UIAlertController(title: self.titileAlert, message: self.bodyAlert, preferredStyle: .alert);
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            self.actionAcept()
        }))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
            self.actionCancel()
        }))
    }
    
    public func actionAcept(){
        
    }
    
    public func actionCancel(){
        
    }
    
}
