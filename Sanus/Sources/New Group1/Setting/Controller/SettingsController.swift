//
//  AjustesController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var listenerState: UISegmentedControl!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    private var uid:String = ""
    private let alert = Alerts()
    private let model = SettingsModel()
    private let login = loginModel()
    private let user = ParamsNewAppointment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = self.user.getID()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataUser()
    }
    
    private func dataUser(){
        self.model.showData( uid: self.uid , completionHandler: { resp in
            let warning = resp["warning"] as! Bool
            if warning {
                print("Se ha producido un error")
            } else {
                
                self.avatar.image = UIImage(data: resp["avatar"]! as! Data)
                self.avatar.layer.masksToBounds = false
                self.avatar.layer.cornerRadius = 25
                self.avatar.clipsToBounds = true
                self.avatar.layer.borderWidth = 1
                self.txtName.text = resp["fullname"] as? String
                
                
                let state = resp["estado"] as? String
                if state == "0" {
                    self.listenerState.selectedSegmentIndex = 1
                } else {
                    self.listenerState.selectedSegmentIndex = 0
                }
                
            }
        })
    }

    @IBAction func btnChangeState(_ sender: UISegmentedControl) {
        if self.listenerState.selectedSegmentIndex == 0 {
            self.login.chageSatateUser(state: "1" )
        } else {
            self.login.chageSatateUser(state: "0" )
        }
    }
    
    @IBAction func btnSignOff(_ sender: UIButton) {
        self.alert.alertAvanced( this: self, titileAlert: "Cerrar sesión", bodyAlert: "¿Esta seguro cerrar su sesión?", actionAcept: "signOut", cancelAlert: nil )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
