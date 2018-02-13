//
//  CrearCuentaController.swift
//  Sanus
//
//  Created by Luis on 02/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CrearCuentaController: UIViewController {

    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var btnCrearcuenta: UIButton!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPass1: UITextField!
    @IBOutlet weak var txtPass2: UITextField!
    var valdE:Bool = false;
    var valdP1:Bool = false;
    var valdP2:Bool = false;
    var ref: DocumentReference!
    var getRef: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRef = Firestore.firestore()
        btnCrearcuenta.isEnabled = false;
        btnCrearcuenta.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
    }
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0{
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    @IBAction func txtEmailEditing(_ sender: UITextField) {
        let num = isValidEmailAddress(emailAddressString: txtCorreo.text!);
        valdE = num;
        validar()
    }
    
    @IBAction func txtPass1Editing(_ sender: UITextField) {
        let num = Int(txtPass1.text!.count);
        if num > 6 {
            valdP1 = true;
        } else {
            valdP1 = false;
        }
        validar()
    }
    
    
    @IBAction func txtPass2Editing(_ sender: UITextField) {
        let num = Int(txtPass2.text!.count);
        if num > 6 {
            let pass1 = txtPass1.text!
            let pass2  = txtPass2.text!
            if pass1 == pass2 {
                valdP2 = true;
            } else {
                valdP2 = false;
            }
        } else {
            valdP2 = false;
        }
        validar()
    }
    

    
    func validar(){
        if ( valdE == true && valdP1 == true  && valdP2 == true) {
            print("validado correcto");
            btnCrearcuenta.backgroundColor = UIColor(red: 255/255, green: 162/255, blue: 0/255, alpha: 1.0);
            btnCrearcuenta.isEnabled = true;
        } else {
            print("formulario invalido");
            btnCrearcuenta.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            btnCrearcuenta.isEnabled = false;
        }
    }
   

    
    @IBAction func btnCrearCuenta(_ sender: UIButton) {
        if txtPass1.text == txtPass2.text {
            self.load.startAnimating()
            Auth.auth().createUser(withEmail: txtCorreo.text!, password: txtPass1.text!) { (user, error) in
                self.load.stopAnimating()
                if user != nil {
                    
                    print("Se ha creado la cuenta con exito")
                    let alerta = UIAlertController(title: " Exito", message: "La la cuenta ha sido creada con exito", preferredStyle: .alert);
                    alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                        self.registrarUsuarios(email: self.txtCorreo.text!, password: self.txtPass1.text!)
                    }))
                    self.present(alerta, animated: true, completion: nil);
                    self.txtCorreo.text! = "";
                    self.txtPass1.text! = "";
                    self.txtPass2.text! = "";
                    
                } else {
                    if  let error = error?.localizedDescription {
                        print("error de firebase", error);
                        if(error == "The password must be 6 characters long or more."){
                            let alerta = UIAlertController(title: " Se ha producido un error", message: "La contraseñas debe tener mas de 6 digitos", preferredStyle: .alert);
                            let aceptar = UIAlertAction( title: "Aceptar", style: .default, handler: nil );
                            alerta.addAction(aceptar);
                            self.present(alerta, animated: true, completion: nil);
                            self.txtPass1.text! = "";
                            self.txtPass2.text! = "";
                        }
                        if(error == "The email address is already in use by another account."){
                            let alerta = UIAlertController(title: " Se ha producido un error", message: "Este correo electronico ya tiene una cuenta con nosotros", preferredStyle: .alert);
                            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                            alerta.addAction(aceptar);
                            self.present(alerta, animated: true, completion: nil);
                            self.txtCorreo.text! = "";
                            self.txtPass1.text! = "";
                            self.txtPass2.text! = "";
                        }
                        if(error == "The email address is badly formatted."){
                            let alerta = UIAlertController(title: " Se ha producido un error", message: "Este no es un correo electronico", preferredStyle: .alert);
                            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                            alerta.addAction(aceptar);
                            self.present(alerta, animated: true, completion: nil);
                            self.txtCorreo.text! = "";
                        }
                    } else {
                        let alerta = UIAlertController(title: "Se ha producido un error", message: error! as? String, preferredStyle: .alert);
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                        alerta.addAction(aceptar);
                        self.present(alerta, animated: true, completion: nil);
                        print("error de codigo", error!);
                    }
                }
            }

            
        } else {
            print("mal")
        }
    }
    
    func registrarUsuarios( email: String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { ( user, error ) in
            let uid = Auth.auth().currentUser?.uid
            let campos:[String:Any] = ["tipo": "Pasiente"]
            self.ref = self.getRef.collection("usuarios").document(uid!)
            self.ref.setData(campos, completion: { (error) in
                if let error = error?.localizedDescription {
                    print("se h producido un error \(error)")
                } else {
                    print("Registro hecho")
                    self.salir()
                    self.performSegue(withIdentifier: "returnlogin", sender: self);
                }
            })
        }
    }
    
    func salir(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "salir", sender: self);
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
