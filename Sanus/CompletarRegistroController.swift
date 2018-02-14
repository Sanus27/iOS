//
//  CompletarRegistroController.swift
//  Sanus
//
//  Created by Luis on 13/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class CompletarRegistroController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var sexo: UISegmentedControl!
    @IBOutlet weak var edad: UIPickerView!
    @IBOutlet weak var btnGuardar: UIButton!
    
    
    var plataforma:String = ""
    var sex:String = ""
    var ed:String = ""
    let plataformas = ["Selecciona tu edad" ,"Recien nacido", "Menor de edad", "De 18 a 25 años", "De 25 años a 50", "Mayor de edad"]
    var valdN:Bool = false;
    var valdA:Bool = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edad.delegate = self
        edad.dataSource = self
        btnGuardar.isEnabled = false;
        btnGuardar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
    }
    
    @IBAction func txtNombreEditing(_ sender: UITextField) {
        let num = Int(txtNombre.text!.count);
        if num > 1 {
            valdN = true;
        } else {
            valdN = false;
        }
        validar();
    }
    
    
    @IBAction func txtApellidoEditing(_ sender: UITextField) {
        let num = Int(txtApellido.text!.count);
        if num > 1 {
            valdA = true;
        } else {
            valdA = false;
        }
        validar();
    }
    
    func validar(){
        if ( valdA == true && valdN == true) {
            print("validado correcto");
            btnGuardar.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
            btnGuardar.isEnabled = true;
        } else {
            print("formulario invalido");
            btnGuardar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            btnGuardar.isEnabled = false;
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
    }
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        let nombre = txtNombre.text!
        let apellido = txtApellido.text!
        
        if sexo.selectedSegmentIndex == 0 {
            sex = "Masculino"
        } else {
            sex = "Femenino"
        }
        print("El sexo es: \(sex)")
        print("Tu edad es: \(ed)")
        print("Tu nombre es: \(nombre)")
        print("Tu apellido es: \(apellido)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
   

}
