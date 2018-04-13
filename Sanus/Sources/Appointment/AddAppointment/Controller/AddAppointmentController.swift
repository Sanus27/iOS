//
//  ResumCitaController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddAppointmentController: UIViewController {
    
    private var ref:DocumentReference!
    private let newAppointment = NewAppointmentModel()
    private let params = ParamsNewAppointment()
    private let alert = Alerts()
    
    @IBOutlet weak var txtNameClinic: UILabel!
    @IBOutlet weak var txtAdress: UILabel!
    @IBOutlet weak var txtNameDoctor: UILabel!
    @IBOutlet weak var txtSpeciality: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtHour: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfo()
    }
    
    private func getInfo(){
        getClinicInfo()
        getDoctorInfo()
        getNameDoctor()
        txtDate.text = params.getCalendar()!
        txtHour.text = params.getHour()!
    }
    
    private func getAvatar( img:String ){
        Storage.storage().reference(forURL: img).getData(maxSize: 10 * 1024 * 1024, completion: { (result, err) in
            if let err = err?.localizedDescription {
                print("fallo al traer imagenes", err)
            } else {
                self.avatar.image = UIImage(data: result!)
                self.avatar.layer.masksToBounds = false
                self.avatar.layer.cornerRadius = self.avatar.frame.height / 2
                self.avatar.clipsToBounds = true
            }
        })
    }
    
    private func getClinicInfo(){
        ref = Firestore.firestore().collection("hospitales").document( self.params.getHospital()! )
        ref.getDocument { (resp, error) in
            if error != nil {
                print("se ha producido un error")
            } else {
                let valClinic = resp?.data()
                self.txtNameClinic.text = valClinic!["nombre"] as? String
                self.txtAdress.text = valClinic!["direccion"] as? String
            }
        }
    }
    
    private func getDoctorInfo(){
        ref = Firestore.firestore().collection("doctores").document( self.params.getDoctor()! )
        ref.getDocument { (resp, error) in
            if error != nil {
                print("se ha producido un error")
            } else {
                let valDoctor = resp?.data()
                self.txtSpeciality.text = valDoctor!["especialidad"] as? String
            }
        }
    }
    
    private func getNameDoctor(){
        ref = Firestore.firestore().collection("usuarios").document( self.params.getDoctor()! )
        ref.getDocument { (resp, error) in
            if error != nil {
                print("se ha producido un error")
            } else {
                let valDoctor = resp?.data()
                var avatar = valDoctor!["avatar"] as? String
                let name = valDoctor!["nombre"] as? String
                let last = valDoctor!["apellido"] as? String
                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                self.getAvatar( img:avatar! )
                let fullname = name! + " " + last!
                self.txtNameDoctor.text = fullname
            }
        }
    }
    
    
    @IBAction func btnCreate(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Registrar nueva cita", message: "Esta seguro en crear la cita?", preferredStyle: .alert);
        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in 
            self.alert.alertSimple(this: self, titileAlert: "Registro exitoso", bodyAlert: "Se ha registrado la cita correctamente", actionAlert: "cancelAppoinment")
        })
        let cancel = UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
            
        })
        alert.addAction(acept);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil);
        

    }
    
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.alert.alertAvanced(this: self, titileAlert: "Cancelación de citas", bodyAlert: "Está seguro de cancelar", actionAcept: "deleteAppoinment", cancelAlert: nil )
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}

