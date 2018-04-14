//
//  Alerts.swift
//  Sanus
//
//  Created by luis on 06/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class Alerts {
    
    private let login = loginModel()
    private let user = ParamsNewAppointment()
    private let appointment = NewAppointmentModel()
    
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
                self.login.chageSatateUser(state: "0")
                try firebaseAuth.signOut()
                logOutFacebook()
                logOutGoogle()
                removeUserDefault()
                this.performSegue( withIdentifier: "salir", sender: this );
            } catch let signOutError as NSError {
                self.alertSimple(this: this, titileAlert: "Se ha producido un error", bodyAlert: "Intentalo mas tarde", actionAlert: nil  )
                print ("Error signing out: %@", signOutError)
            }
        }
        if acept == "cancelAppoinment" {
            self.removeUserDefault()
            self.deleteAppointment( this:this )
            this.dismiss(animated: true, completion: nil )
        }
        if acept == "deleteAppoinment" {
            self.deleteAppointment( this:this )
        }
    }
    
    private func deleteAppointment( this: UIViewController  ){
        self.appointment.deleteAppintment { resp in
            self.removeUserDefault()
            this.dismiss(animated: true, completion: nil )
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
    
    private func removeUserDefault(){
        self.user.removeDoctor()
        self.user.removeIdRegister()
        self.user.removeDay()
        self.user.removeHospital()
        self.user.removeHour()
        self.user.removeCalendar()
    }
    
    private func logOutFacebook(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    private func logOutGoogle(){
        GIDSignIn.sharedInstance().signOut()
        self.user.removeID()
        self.user.removeTypeUser()
    }
    
}

