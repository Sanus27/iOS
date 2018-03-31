//
//  CreateUserModel.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateUserModel: UIViewController {

    private var resp: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func createUser(txtEmail: String, txtPassword: String, completionHandler: @escaping ((String) -> Void)) {
        Auth.auth().createUser( withEmail: txtEmail, password: txtPassword ) { (user, error) in
        
            if user != nil {
                
                Auth.auth().signIn( withEmail: txtEmail, password: txtPassword ) { ( usr, err ) in
                    if usr != nil {
                        self.resp = "success"
                        completionHandler( self.resp! )
                    } else {
                        if let err = err?.localizedDescription {
                            print(err)
                        }
                    }
                }
                
            } else {
                if let error = error?.localizedDescription {
                    self.resp = error
                    completionHandler( self.resp! )
                }
            }
        }
    }

   
}
