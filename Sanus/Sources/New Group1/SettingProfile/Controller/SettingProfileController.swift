//
//  SettingProfileController.swift
//  Sanus
//
//  Created by luis on 12/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingProfileController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var listenerName: UITextField!
    @IBOutlet weak var listenerLastname: UITextField!
    @IBOutlet weak var listenerSex: UISegmentedControl!
    @IBOutlet weak var listenerYear: UIPickerView!
    @IBOutlet weak var listenerSave: UIButton!
    @IBOutlet weak var listenerReturn: UIButton!
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    private var model = SettingProfileModel()
    private var alert = Alerts()
    private var ref:DocumentReference!
    private var sexx:Int = 27
    private var imagen = UIImage()
    private var pesoImg:Float = 0.0
    private var plataforma:String = ""
    private var campos: [String:Any] = [:]
    private var plataformas = ["Selecciona tu edad", "1 Año"]
    private var ed:String = ""
    private var miyear:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenerYear.delegate = self
        listenerYear.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let uid = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( uid )
        setYears()
        dataUser()
    }
    
    private func setYears(){
        for i in 2...99 {
            plataformas.append("\(i) Años")
        }
    }
    
    private func dataUser(){
        self.model.dataUser(this: self, completionHandler: { resp in
            let displayError:Bool = resp["display-error"]! as! Bool
            if displayError {
                self.alert.alertSimple(this: self, titileAlert: "Se ha producido un error", bodyAlert: "Intentalo mas tarde", actionAlert: nil )
            } else {
                let avatar: String? = resp["avatar"] as? String
                let lastname: String = resp["apellido"] as! String
                let name: String = resp["nombre"] as! String
                let sex: String = resp["sex"] as! String
                //let year: String = resp["year"] as! String
                
                if avatar != nil {
                    Storage.storage().reference( forURL: avatar! ).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            print("fallo al traer imagenes", error)
                        } else {
                            self.avatar.image = UIImage(data: data!)
                            self.avatar.layer.masksToBounds = false
                            self.avatar.layer.cornerRadius = 40
                            self.avatar.clipsToBounds = true
                            self.avatar.layer.borderWidth = 1
                        }
                    })
                } else {
                    self.avatar.image = #imageLiteral(resourceName: "user")
                }
                
                if sex == "Femenino" {
                    self.sexx = 1
                }
                if sex == "Masculino" {
                    self.sexx = 0
                }

                self.listenerName.text = name
                self.listenerLastname.text = lastname
                self.listenerSex.selectedSegmentIndex  = self.sexx
                self.listenerYear.selectRow( self.miyear , inComponent: 0, animated: true)

                
            }
            
        })

    }

    @IBAction func editingNameChange(_ sender: UITextField) {
        
    }
    
    @IBAction func editingLastNameChange(_ sender: UITextField) {
        
    }
    
    @IBAction func btnSelectPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])  {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        avatar.image = imagenTomada!
        imagen = imagenTomada!
        pesoImg = Float(imagen.size.width)
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plataformas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataformas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plataforma = plataformas[row]
        ed = plataformas[row]
        if plataformas[row] == "Selecciona tu edad" {
            ed = ""
        }
    }
    
    @IBAction func btnReturn(_ sender: UIButton) {
        dismiss( animated: true, completion: nil )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
