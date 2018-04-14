//
//  ConectFalseController.swift
//  Sanus
//
//  Created by luis on 06/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Lottie

class ConectFalseController: UIViewController {

    private var reachability: Reachability!
    let animationView = LOTAnimationView(name: "sin-internet")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:400)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        //animationView.backgroundColor = UIColor.red
        self.view.addSubview(animationView)
        animationView.play()
        
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
