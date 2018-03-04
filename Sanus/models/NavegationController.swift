//
//  NavegationController.swift
//  Sanus
//
//  Created by luis on 03/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class NavegationController: UINavigationController {
    
    
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
                let login = self.setStory(name: "loginTrue")
                self.present(login, animated: true, completion: nil)
            } else {
                let login = self.setStory(name: "loginFalse")
                self.present(login, animated: true, completion: nil)
            }
        }
    }

    
}
