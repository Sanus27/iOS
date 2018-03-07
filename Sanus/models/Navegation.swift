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
    var sesion: Bool = false
    
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
                let sesion = self.isLoggedIfisCompleate()
                if sesion {
                    let inicio = self.setStory(name: "loginTrue")
                    self.present(inicio, animated: true, completion: nil)
                } else {
                    let register = self.setStory(name: "completeRegister")
                    self.present(register, animated: true, completion: nil)
                }
            } else {
                let login = self.setStory(name: "loginFalse")
                self.present(login, animated: true, completion: nil)
            }
        }
    }
    
    public func isLoggedIfisCompleate() -> Bool {
        let id = (Auth.auth().currentUser?.uid)!
        ref = Firestore.firestore().collection("usuarios").document( id )
        ref.getDocument { (document, error) in
          
            if let document = document {
                if document.data() != nil {
                    print("terminado splash")
                    self.sesion = true
                } else {
                    print("falta splash")
                    self.sesion = false
                }
            }

           
        }
    
        return self.sesion
    }
    
    
}
