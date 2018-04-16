//
//  LoadController.swift
//  Sanus
//
//  Created by luis on 15/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Lottie

class LoadController: UIViewController {

    private var reachability: Reachability!
    let animationView = LOTAnimationView(name: "loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:400)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.play()
        isConected()
    }

    public func isConected(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isConected()
    }
    
    public func isLoading(){
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.isLoading()
    }
   

}
