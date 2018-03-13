//
//  ViewController.swift
//  Sanus
//
//  Created by Luis on 02/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var load: UIActivityIndicatorView!
    var valdE:Bool = false;
    var valdP:Bool = false;
    var ref: DocumentReference!
    private let login = loginModel()
    private let alert = Alerts()
    override func loadView() {
        super.loadView()
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtPassword.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.isEnabled = true;
        btnLogin.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
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
        valid();
    }
    
    @IBAction func txtEmailEditing(_ sender: UITextField) {
        let num = isValidEmailAddress(emailAddressString: txtEmail.text!);
        valdE = num;
        valid();
    }
    
    func valid(){
        if ( valdE == true && valdP == true) {
            btnLogin.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
            btnLogin.isEnabled = true;
        } else {
            btnLogin.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            btnLogin.isEnabled = false;
        }
    }
    
    

    
    @IBAction func loginAction(_ sender: UIButton) {
    
        self.load.startAnimating()
        self.login.startLogin( txtEmail: txtEmail.text!, txtPassword: txtPassword.text!, completionHandler: { resp in
            self.load.stopAnimating()
            if resp == "success" {
                self.login.isLoggedIsCompleateLogin( this: self )
            } else {
                if(resp == "The password is invalid or the user does not have a password."){
                    self.alert.alertSimple( this: self, titileAlert: "Alerta", bodyAlert: "El correo y/o contraseña con incorrectos", actionAlert: nil )
                }
                if(resp == "There is no user record corresponding to this identifier. The user may have been deleted."){
                    self.alert.alertAvanced( this: self, titileAlert: "Correo no esta registrado", bodyAlert: "¿Desea crear una cuenta?", actionAlert: "login")
                }
                self.txtPassword.text! = "";
                self.txtEmail.text! = "";
                self.valdE = false;
                self.valdP = false;
            }
        })
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
}

