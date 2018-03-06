//
//  SelectDoctorCitasController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//


import UIKit

class SelecionaDoctorController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var doctors: UIPickerView!
    var items = ["Selecciona tu doctor"]
    var doctor:String = ""
    var ed:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        doctors.delegate = self
        doctors.dataSource = self
        setDoctores()
        // Do any additional setup after loading the view.
    }
    
    func setDoctores(){
        for i in 1...127 {
            items.append("Doctor # \(i)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doctor = items[row]
        ed = items[row]
        if items[row] == "Selecciona tu doctor" {
            ed = ""
        }
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        
    }
    
    
    
    
}
