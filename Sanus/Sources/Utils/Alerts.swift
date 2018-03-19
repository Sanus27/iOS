//
//  Alerts.swift
//  Sanus
//
//  Created by luis on 06/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Alerts {
    
    private var resp:Int = 0
    private var conta:Int = 270
    
    public func alertSimple( this: UIViewController, titileAlert: String?, bodyAlert: String?, actionAlert: String? ) -> Void {
        let alert = UIAlertController(title: titileAlert, message: bodyAlert, preferredStyle: .alert);
        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            self.actionAcept( this:this, acept: actionAlert )
        })
        alert.addAction(acept);
        this.present(alert, animated: true, completion: nil);
    }
    
    public func alertAvanced( this: UIViewController, titileAlert: String?, bodyAlert: String?, actionAcept: String?, cancelAlert: String? ) -> Void {
        let alert = UIAlertController(title: titileAlert, message: bodyAlert, preferredStyle: .alert);
        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
            self.actionAcept( this:this, acept: actionAcept )
        })
        let cancel = UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
            self.actionCancel( this:this, cancel: cancelAlert )
        })
        alert.addAction(acept);
        alert.addAction(cancel);
        this.present(alert, animated: true, completion: nil);
    }
    
    public func prueba() ->Int {
        
        func dentro() -> Int {
            if conta == 27 {
                self.resp = 1
            } else {
                self.resp = 2
            }
            return self.resp
        }
        
        return dentro()
        
    }
    
 
    private func actionAcept( this: UIViewController, acept: String?  ){
        if acept == "login" {
            this.performSegue(withIdentifier: "returnCreateUser", sender: this);
        }
        if acept == "completeRegister" {
            this.performSegue(withIdentifier: "goBuscador", sender: this);
        }
        if acept == "signOut" {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                this.performSegue( withIdentifier: "salir", sender: this );
            } catch let signOutError as NSError {
                self.alertSimple(this: this, titileAlert: "Se ha producido un error", bodyAlert: "Intentalo mas tarde", actionAlert: nil  )
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    private func actionCancel( this: UIViewController, cancel: String? ){
        if cancel == "signOut" {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                this.performSegue( withIdentifier: "completeLoginFalse", sender: this );
            } catch let signOutError as NSError {
                self.alertSimple(this: this, titileAlert: "Se ha producido un error", bodyAlert: "Intentalo mas tarde", actionAlert: nil  )
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    
}