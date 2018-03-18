//
//  NavegationController.swift
//  Sanus
//
//  Created by luis on 03/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Navegation: UINavigationController {
    
    var ref: DocumentReference!
    var sesion: NSNumber = 27
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        isLoggedIn()
    }
    
    public func setStory(name: String) -> UIViewController {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return mainStoryBoard.instantiateViewController(withIdentifier: name)
    }
    
    
    public func isLoggedIn() {
        Auth.auth().addStateDidChangeListener{ ( auth, user ) in
            if user != nil {
                self.isLoggedIfisCompleate()
            } else {
                let login = self.setStory(name: "loginFalse")
                self.present(login, animated: true, completion: nil)
            }
        }
    }
    
    public func isLoggedIfisCompleate()  {
        
        let id = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( id )
        ref.getDocument { (document, error) in
            
            if let document = document {
                let exist = document.data()
                if exist != nil {
                    let typeData = exist!["tipo"] as! String
                    if typeData == "Medico" {
                        let inicio = self.setStory(name: "loginTrueDoctor")
                        self.present(inicio, animated: true, completion: nil )
                    }
                    if typeData == "Paciente" {
                        let inicio = self.setStory(name: "loginTrue")
                        self.present(inicio, animated: true, completion: nil )
                    }
                } else {
                    let register = self.setStory(name: "completeRegister")
                    self.present(register, animated: true, completion: nil)
                }
            }
            
           
        }
    
    }
    
    

    
    
}
