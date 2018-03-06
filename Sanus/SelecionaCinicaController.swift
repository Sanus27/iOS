//
//  NuevaCitaController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SelecionaCinicaController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var clinic: UIPickerView!
    var plataforms = ["Selecciona tu clinica"]
    var plataform:String = ""
    var ed:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clinic.delegate = self
        clinic.dataSource = self
        setClinic()
    }
    
    lazy var VCArr: [UIViewController] = {
        return [
            self.VCInstance(name: "SelectDoctormio"),
            self.VCInstance(name: "SelectClinica"),
            self.VCInstance(name: "SelectDay"),
            self.VCInstance(name: "SelectHours"),
            self.VCInstance(name: "SaveCite")
        ]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    func setClinic(){
        for i in 1...127 {
            plataforms.append("Clinica # \(i)")
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plataforms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataforms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plataform = plataforms[row]
        ed = plataforms[row]
        if plataforms[row] == "Selecciona tu clinica" {
            ed = ""
        }
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let NextPage =  [
            self.VCInstance(name: "SelectDoctormio")
        ]
        print(NextPage)
        //present(NextPage, animated: true, completion: nil)
            //setViewControllers([NextPage], direction: .forward, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnAtras(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
