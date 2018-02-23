//
//  ViewController.swift
//  Sanus
//
//  Created by Luis on 02/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var btnIniciarSesion: UIButton!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var load: UIActivityIndicatorView!
    var valdE:Bool = false;
    var valdP:Bool = false;
    
    override func loadView() {
        super.loadView()
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnIniciarSesion.isEnabled = false;
        btnIniciarSesion.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
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
    

    @IBAction func txtPassEditing(_ sender: UITextField) {
        let num = Int(txtPassword.text!.count);
        if num > 6 {
            valdP = true;
        } else {
            valdP = false;
        }
        validar();
    }
    
    @IBAction func txtEmailEditing(_ sender: UITextField) {
        let num = isValidEmailAddress(emailAddressString: txtCorreo.text!);
        valdE = num;
        validar();
    }
    
    func validar(){
        if ( valdE == true && valdP == true) {
            btnIniciarSesion.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
            btnIniciarSesion.isEnabled = true;
        } else {
            btnIniciarSesion.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            btnIniciarSesion.isEnabled = false;
        }
    }
    
    
    @IBAction func btnIniciarSesion(_ sender: UIButton) {
        self.load.startAnimating()
        Auth.auth().signIn(withEmail: txtCorreo.text!, password: txtPassword.text!) { ( user, error ) in
            
            self.load.stopAnimating()
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                if let error = error?.localizedDescription {
                    
                    if(error == "The email address is badly formatted."){
                        let alerta = UIAlertController(title: "Alerta", message: "Este no es un correo electronico", preferredStyle: .alert);
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                        alerta.addAction(aceptar);
                        self.present(alerta, animated: true, completion: nil);
                        self.txtCorreo.text! = "";
                        self.valdE = false;
                    }
                    if(error == "The password is invalid or the user does not have a password."){
                        let alerta = UIAlertController(title: "Alerta", message: "El correo y/o contraseña con incorrectos", preferredStyle: .alert);
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                        alerta.addAction(aceptar);
                        self.present(alerta, animated: true, completion: nil);
                        self.txtPassword.text! = "";
                        self.txtCorreo.text! = "";
                        self.valdE = false;
                        self.valdP = false;
                    }
                    if(error == "There is no user record corresponding to this identifier. The user may have been deleted."){
                        let alerta = UIAlertController(title: "Correo no esta registrado", message: "¿Desea crear una cuenta?", preferredStyle: .alert);
                        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action) in
                            self.performSegue(withIdentifier: "RcrearCuenta", sender: self);
                        }))
                        alerta.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil ))
                        self.present(alerta, animated: true, completion: nil);
                        self.txtPassword.text! = "";
                        self.txtCorreo.text! = "";
                        self.valdE = false;
                        self.valdP = false;
                    }
                    
                } else {
                    self.txtPassword.text! = "";
                    self.valdE = false;
                    self.valdP = false;
                    print("error de codigo")
                }
            }
        }
    }
    
    func login(){
        Auth.auth().addStateDidChangeListener{ ( auth, user ) in
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self);
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
}

