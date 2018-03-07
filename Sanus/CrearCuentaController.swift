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
    
    @IBOutlet weak var listenerBtnShow: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var listenerCreateUser: UIButton!
    @IBOutlet weak var listenerDismis: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    var valdE:Bool = false
    var valdP1:Bool = false
    var valdP2:Bool = false
    var iconClick = true
    var ref: DocumentReference!
    var getRef: Firestore!
    var pass:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRef = Firestore.firestore()
        listenerBtnShow.setTitle("Mostrar", for: .normal)
        txtPassword.isSecureTextEntry = true
        listenerCreateUser.isEnabled = false;
        listenerCreateUser.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
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
        let num = isValidEmailAddress(emailAddressString: txtEmail.text!);
        valdE = num;
        validate()
    }
    
    @IBAction func txtPassEditing(_ sender: UITextField) {
        let num = Int(txtPassword.text!.count);
        if num > 6 {
            valdP1 = true;
        } else {
            valdP1 = false;
        }
        validate()
    }
    
    
    func validate(){
        if ( valdE == true && valdP1 == true ) {
            listenerCreateUser.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
            listenerCreateUser.isEnabled = true;
            pass = self.txtPassword.text!
        } else {
            listenerCreateUser.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            listenerCreateUser.isEnabled = false;
        }
    }
   
    

    @IBAction func btnCreateUser(_ sender: UIButton) {
        
        
        listenerDismis.isEnabled = false;
        txtPassword.isSecureTextEntry = true
        listenerDismis.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
        
       
            self.load.startAnimating()
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
                
                if user != nil {
                    
                    let email = user?.email
                    Auth.auth().signIn(withEmail: email!, password: self.pass) { ( usr, err ) in
                        if usr != nil {
                            self.performSegue(withIdentifier: "firstLogin", sender: self);
                        } else {
                            if let err = err?.localizedDescription {
                                print(err)
                            }
                        }
                    }
                    self.txtEmail.text! = "";
                    self.txtPassword.text! = "";
                    
                } else {
                    
                    self.listenerDismis.isEnabled = true;
                    self.listenerDismis.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 0.3);
                    
                    if  let error = error?.localizedDescription {
                        print("error de firebase", error);
                        if(error == "The password must be 6 characters long or more."){
                            let alerts = UIAlertController(title: " Se ha producido un error", message: "La contraseñas debe tener mas de 6 digitos", preferredStyle: .alert);
                            let acept = UIAlertAction( title: "Aceptar", style: .default, handler: nil );
                            alerts.addAction(acept);
                            self.present(alerts, animated: true, completion: nil);
                            self.txtPassword.text! = "";
                        }
                        if(error == "The email address is already in use by another account."){
                            let alerts = UIAlertController(title: " Se ha producido un error", message: "Este correo electronico ya tiene una cuenta con nosotros", preferredStyle: .alert);
                            let acept = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                            alerts.addAction(acept);
                            self.present(alerts, animated: true, completion: nil);
                            self.txtEmail.text! = "";
                            self.txtPassword.text! = "";
                        }
                        if(error == "The email address is badly formatted."){
                            let alerts = UIAlertController(title: " Se ha producido un error", message: "Este no es un correo electronico", preferredStyle: .alert);
                            let acept = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                            alerts.addAction(acept);
                            self.present(alerts, animated: true, completion: nil);
                            self.txtEmail.text! = "";
                        }
                    } else {
                        let alerts = UIAlertController(title: "Se ha producido un error", message: error! as? String, preferredStyle: .alert);
                        let acept = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                        alerts.addAction(acept);
                        self.present(alerts, animated: true, completion: nil);
                        print("error de codigo", error!);
                    }
                }
            }


    }
    
    

    @IBAction func btnShowPass(_ sender: UIButton) {
        if(iconClick == true) {
            listenerBtnShow.setTitle("Ocultar", for: .normal)
            txtPassword.isSecureTextEntry = false
            iconClick = false
        } else {
            listenerBtnShow.setTitle("Mostrar", for: .normal)
            txtPassword.isSecureTextEntry = true
            iconClick = true
        }
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
