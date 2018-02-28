//
//  PerfilDoctorController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PerfilDoctorController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var txtCV: UILabel!
    @IBOutlet weak var txtEspecialidad: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtCedula: UILabel!
    
    @IBOutlet weak var starUno: UIButton!
    @IBOutlet weak var starDos: UIButton!
    @IBOutlet weak var starCuatro: UIButton!
    @IBOutlet weak var starTres: UIButton!
    @IBOutlet weak var starCinco: UIButton!
    
    var verPerfil:Doctores!
    var ref: DocumentReference!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = verPerfil.id!
        ref = Firestore.firestore().collection("doctores").document(id)
        mostrar()
    }
    
    func mostrar(){
        ref.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let nombre = val!["nombre"] as! String
                self.navbar.title = nombre
                let foto = val!["avatar"] as! String
                let cv = val!["cv"] as! String
                self.txtCV.text = cv
                let especialidad = val!["especialidad"] as! String
                self.txtEspecialidad.text = especialidad
                let cedula = val!["cedula"] as! String
                self.txtCedula.text = cedula
                let calif = val!["calificacion"] as! String
                //print(calif)
                
                if calif != "" {
                    if calif == "20" {
                        self.starUno.setTitle("★", for: .normal)
                    }
                    if calif == "40" {
                        self.starUno.setTitle("★", for: .normal)
                        self.starDos.setTitle("★", for: .normal)
                    }
                    if calif == "60" {
                        self.starUno.setTitle("★", for: .normal)
                        self.starDos.setTitle("★", for: .normal)
                        self.starTres.setTitle("★", for: .normal)
                    }
                    if calif == "80" {
                        self.starUno.setTitle("★", for: .normal)
                        self.starDos.setTitle("★", for: .normal)
                        self.starTres.setTitle("★", for: .normal)
                        self.starCuatro.setTitle("★", for: .normal)
                    }
                    if calif == "100" {
                        self.starUno.setTitle("★", for: .normal)
                        self.starDos.setTitle("★", for: .normal)
                        self.starTres.setTitle("★", for: .normal)
                        self.starCuatro.setTitle("★", for: .normal)
                        self.starCinco.setTitle("★", for: .normal)
                    }
                }
                
                if foto != "" {
                    Storage.storage().reference(forURL: foto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                        if let error = error?.localizedDescription {
                            print("fallo al traer imagenes", error)
                        } else {
                            self.avatar.image = UIImage(data: data!)
                            self.avatar.layer.masksToBounds = false
                            self.avatar.layer.cornerRadius = self.avatar.frame.height / 2
                            self.avatar.clipsToBounds = true
                            self.avatar.layer.borderWidth = 1
                        }
                    })
                }
                
            } else {
                print("documento no existe")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comentarios" {
            let destino = segue.destination as! ComentariosDrController
            destino.verComentarios = id
        }
        if segue.identifier == "nuevoComentario" {
            let destino = segue.destination as! NuevoComentarioDrController
            destino.nuevoComentario = id
        }
    }
    
    @IBAction func btnComentarios(_ sender: UIButton) {
        performSegue(withIdentifier: "comentarios", sender: self)
    }
    
    @IBAction func btnNuevoComentario(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevoComentario", sender: self)
    }
    
    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
    
}
