//
//  ConectFalseController.swift
//  Sanus
//
//  Created by luis on 06/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class ConectFalseController: UIViewController {

    private var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reachability = Reachability.init()
        NotificationCenter.default.addObserver(self, selector: #selector(conexion), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("se ha producido un error")
        }
    }
    
    @objc func conexion( note:Notification ){
        let reach = note.object as! Reachability
        if reach.connection == .cellular || reach.connection == .wifi {
            dismiss(animated: true, completion: nil )
        }
    }

    

}
