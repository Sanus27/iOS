//
//  SettingProfileController.swift
//  Sanus
//
//  Created by luis on 12/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SettingProfileController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var listenerName: UITextField!
    @IBOutlet weak var listenerLastname: UITextField!
    @IBOutlet weak var listenerSex: UISegmentedControl!
    @IBOutlet weak var listenerYear: UIPickerView!
    @IBOutlet weak var listenerSave: UIButton!
    @IBOutlet weak var listenerReturn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func editingNameChange(_ sender: UITextField) {
        
    }
    
    @IBAction func editingLastNameChange(_ sender: UITextField) {
        
    }
    
    @IBAction func btnSelectPhoto(_ sender: UIButton) {
        
    }
    
    @IBAction func btnReturn(_ sender: UIButton) {
        dismiss( animated: true, completion: nil )
    }
    
    
}
