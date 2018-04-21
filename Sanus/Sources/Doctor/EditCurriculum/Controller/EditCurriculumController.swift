//
//  EditCurriculumController.swift
//  Sanus
//
//  Created by luis on 20/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class EditCurriculumController: UIViewController {

    private var ref:DocumentReference!
    private let alert = Alerts()
    private var uid:String = ""
    private let user = ParamsNewAppointment()
    @IBOutlet weak var txtCV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = self.user.getID()!
        self.showData(uid: self.uid, completionHandler: { resp in
            
        })
    }

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func showData( uid: String ,completionHandler: @escaping (([String:Any]) -> Void)) {
        
        isConected()
        ref = Firestore.firestore().collection("doctores").document( uid )
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let cv = val!["cv"] as? String
                self.txtCV.text = cv
            } else {
                print("documento no existe")
            }
        }
        
    }
    
    public func addCV( uid: String, cv: String, completionHandler: @escaping ((String) -> Void)) {
     
        isConected()
        self.ref = Firestore.firestore().collection("doctores").document( uid )
        self.ref.updateData([
            "cv": cv
        ]) { err in
            
            if err != nil {
                completionHandler("Se ha producido un error, intentelo nuevamente")
            } else {
                completionHandler("success")
            }
            
        }
        
    }
    
    @IBAction func btnCv(_ sender: UIButton) {
        if txtCV.text != nil {
            self.addCV(uid: self.uid, cv: txtCV.text!, completionHandler: { resp in
                if resp == "success" {
                    self.alert.alertSimple(this: self, titileAlert: "Guardando cambios", bodyAlert: "Se han guardado los cambios correctamente", actionAlert: "cancelAppoinment")
                } else {
                    self.alert.alertSimple(this: self, titileAlert: "Se ha producido un error", bodyAlert: "Error al guardar los cambios, intentalo mas tarde", actionAlert: nil)
                }
            })
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        dismiss( animated: true, completion: nil )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
