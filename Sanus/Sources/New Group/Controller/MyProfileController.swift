//
//  MyProfileController.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyProfileController: UIViewController {

    private var uid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = (Auth.auth().currentUser?.uid)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnComents(_ sender: UIButton) {
        performSegue(withIdentifier: "goComents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goComents" {
            let destiny = segue.destination as! ComentariosDrController
            destiny.showComents = self.uid
        }
    }

}
