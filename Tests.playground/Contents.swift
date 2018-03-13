//: Playground - noun: a place where people can play

import UIKit

class Alerts {
    
    var resp:Int = 0
    
    func alertAvanced( titileAlert: String?, bodyAlert: String? ) ->Int {
        if titileAlert == "Hola" {
            self.resp = 15
            return self.resp
        } else {
            self.resp = 27
            return self.resp
        }
    }
    
}

class QuePedo {
    
    var alerta = Alerts()
    let res = alerta.alertAvanced( titileAlert: "Hola", bodyAlert: "como estas" )
    print(res)
    
}

