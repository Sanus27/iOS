//
//  MessengerDrController.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessengerDrController: UIViewController {

    private var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = Auth.auth().currentUser?.uid
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        performSegue(withIdentifier: "goMessengerDoctor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMessengerDoctor" {
            let destino = segue.destination as! MessegeClientController
            destino.showMessenger = self.uid
        }
    }

}
