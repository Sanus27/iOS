//
//  ChatController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatController: UIViewController {

    private var uid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = Auth.auth().currentUser?.uid
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        performSegue(withIdentifier: "goMessengerPacient", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMessengerPacient" {
            let destino = segue.destination as! MessegeClientController
            destino.showMessenger = self.uid
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
