//
//  CompletarRegistroController.swift
//  Sanus
//
//  Created by Luis on 13/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CompletarRegistroController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    var imageDefault = "gs://sanus-27.appspot.com/images/user.png"
    var ref: DocumentReference!
    var getRef: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        getRef = Firestore.firestore()
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
        Auth.auth().addStateDidChangeListener{ ( auth, user ) in
            if user != nil {
                let alerts = UIAlertController(title: "Sanus", message: "Para completar el registro necesitamos algunos datos", preferredStyle: .alert);
                alerts.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                    
                }))
                alerts.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
                    self.signOff()
                }))
                self.present(alerts, animated: true, completion: nil);
            }
        }
    }
    
    public func setStory(name: String) -> UIViewController {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return mainStoryBoard.instantiateViewController(withIdentifier: name)
    }
    
    public func signOff(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let inicio = self.setStory(name: "loginFalse")
            self.present(inicio, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
            let storage = Storage.storage().reference()
            let directorio = storage.child("avatar/\(id!)")
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            directorio.putData(UIImagePNGRepresentation(imagen)!, metadata: metaData) { (data, error) in
                if error == nil {
                    print("cargo la imagen")
                    self.load.stopAnimating()
                } else {
                    if let error = error?.localizedDescription {
                        print("Error al subir imagen", error)
                    } else {

                    }
                }
            }
            
            if ed != "" {
                campos = ["avatar": String(describing: directorio), "nombre": nombre, "apellido": apellido, "edad": ed, "sexo": sex, "tipo": "Paciente" ]
            } else {
                campos = ["avatar": String(describing: directorio), "nombre": nombre, "apellido": apellido, "sexo": sex, "tipo": "Paciente" ]
            }
            
        } else {
            
            if ed != "" {
                campos = ["avatar": String(describing: imageDefault), "nombre": nombre, "apellido": apellido, "edad": ed, "sexo": sex, "tipo": "Paciente" ]
            } else {
                campos = ["avatar": String(describing: imageDefault), "nombre": nombre, "apellido": apellido, "sexo": sex, "tipo": "Paciente" ]
            }
        }
        
        //insertar datos
        ref = Firestore.firestore().collection("usuarios").document(id!)
        ref.setData(campos) { (error) in
            if let error = error?.localizedDescription {
                print("fallo al actualizar", error)
                let alerta = UIAlertController(title: "Se ha producido un error", message: "Intentalo de nuevo", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                    
                }))
            } else {
                let alerta = UIAlertController(title: "Se han actualizado tus datos", message: "Ahora puedes utilizar nuestra aplicación", preferredStyle: .alert);
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                    self.performSegue(withIdentifier: "goBuscador", sender: self);
                }))
                self.present(alerta, animated: true, completion: nil);
            }
        }
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
        print(pesoImg)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
   

}
