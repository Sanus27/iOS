//
//  SelectDoctorCitasController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//


import UIKit

class SelecionaDoctorController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var ListaDoctores: UIPickerView!
    var plataformas = ["Selecciona tu doctor"]
    var plataforma:String = ""
    var ed:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ListaDoctores.delegate = self
        ListaDoctores.dataSource = self
        setDoctores()
        // Do any additional setup after loading the view.
    }
    
    func setDoctores(){
        for i in 1...127 {
            plataformas.append("Doctor # \(i)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plataformas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataformas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plataforma = plataformas[row]
        ed = plataformas[row]
        if plataformas[row] == "Selecciona tu doctor" {
            ed = ""
        }
    }
    
    
    
}
