//
//  CompletarRegistroController.swift
//  Sanus
//
//  Created by Luis on 13/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class CompleteUserController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var sexo: UISegmentedControl!
    @IBOutlet weak var edad: UIPickerView!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    var plataforma:String = ""
    var sex:String = ""
    var ed:String = ""
    var uid:String = ""
    var campos: [String:Any] = [:]
    var plataformas = ["Selecciona tu edad", "1 Año"]
    var valdN:Bool = false
    var valdA:Bool = false
    var imagen = UIImage()
    var pesoImg:Float = 0.0
    private var imgDefault = "user_defaul"
    private let alert = Alerts()
    private var model = CompleteUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        edad.delegate = self
        edad.dataSource = self
        self.imageView.layer.masksToBounds = false
        self.imageView.layer.cornerRadius = 40
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        btnGuardar.isEnabled = false;
        btnGuardar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
        getAlert()
        setYears()
    }
    
    func getAlert(){
        self.model.getAlert(this: self, completionHandler: { resp in
            if resp == "success" {
                self.alert.alertAvanced(this: self, titileAlert: "Sanus", bodyAlert: "Para completar el registro necesitamos algunos datos", actionAcept: nil, cancelAlert: "signOut" )
            }
        })
    }
    
    public func setStory(name: String) -> UIViewController {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return mainStoryBoard.instantiateViewController(withIdentifier: name)
    }
    
    
    func setYears(){
        for i in 2...99 {
            plataformas.append("\(i) Años")
        }
    }
    
    @IBAction func txtNombreEditing(_ sender: UITextField) {
        let num = Int(txtNombre.text!.count);
        if num > 1 {
            valdN = true;
        } else {
            valdN = false;
        }
        validar();
    }
    
    
    @IBAction func txtApellidoEditing(_ sender: UITextField) {
        let num = Int(txtApellido.text!.count);
        if num > 1 {
            valdA = true;
        } else {
            valdA = false;
        }
        validar();
    }
    
    func validar(){
        if ( valdA == true && valdN == true) {
            btnGuardar.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
            btnGuardar.isEnabled = true;
        } else {
            btnGuardar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            btnGuardar.isEnabled = false;
        }
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
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        load.startAnimating()
        btnGuardar.isEnabled = false;
        btnGuardar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
        
        let id = Auth.auth().currentUser?.uid
        let nombre = txtNombre.text!
        let apellido = txtApellido.text!
        if sexo.selectedSegmentIndex == 0 { sex = "Masculino" } else { sex = "Femenino" }
        //subir imagen
        if pesoImg != 0.0 {
            let avatar = id!
            
            self.model.uploadPicture( imagen: imagen, completionHandler: { resp in
                if resp == "success" {
                    print("cargo la imagen")
                    self.load.stopAnimating()
                } else {
                    print("Error al subir imagen", resp)
                }
            })
            
            if ed != "" {
                campos = [ "avatar": String(describing: avatar), "nombre": nombre, "apellido": apellido, "edad": ed, "sexo": sex, "tipo": "Paciente", "estado": "1" ]
            } else {
                campos = [ "avatar": String(describing: avatar), "nombre": nombre, "apellido": apellido, "sexo": sex, "tipo": "Paciente", "estado": "1" ]
            }
            
        } else {
            //
            if ed != "" {
                campos = [ "avatar": String(describing: imgDefault), "nombre": nombre, "apellido": apellido, "edad": ed, "sexo": sex, "tipo": "Paciente", "estado": "1" ]
            } else {
                campos = [ "avatar": String(describing: imgDefault), "nombre": nombre, "apellido": apellido, "sexo": sex, "tipo": "Paciente", "estado": "1" ]
            }
        }
        
        //insertar datos
        self.model.completeUser( data: campos, id: id!, completionHandler: { resp in
            if resp == "success" {
                self.alert.alertSimple(this: self, titileAlert: "Se han actualizado tus datos", bodyAlert: "Ahora puedes utilizar nuestra aplicación", actionAlert: "completeRegister")
            } else {
                self.alert.alertSimple( this: self, titileAlert: "Se ha producido un error", bodyAlert: "Intentalo de nuevo", actionAlert: nil )
            }
        })
        
    }
    
    
    @IBAction func btnCargarFoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])  {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        imageView.image = imagenTomada!
        imagen = imagenTomada!
        pesoImg = Float(imagen.size.width)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
   

}
