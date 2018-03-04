//
//  NuevaCitaController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SelecionaCinicaController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var clinica: UIPickerView!
    var plataformas = ["Selecciona tu clinica"]
    var plataforma:String = ""
    var ed:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clinica.delegate = self
        clinica.dataSource = self
        setClinica()
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
    
    func setClinica(){
        for i in 1...127 {
            plataformas.append("Clinica # \(i)")
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
        if plataformas[row] == "Selecciona tu clinica" {
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
