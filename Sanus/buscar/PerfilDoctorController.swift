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
    @IBOutlet weak var txtSpecialty: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtIdCard: UILabel!
    @IBOutlet weak var StarOne: UIButton!
    @IBOutlet weak var StarTwo: UIButton!
    @IBOutlet weak var StarThree: UIButton!
    @IBOutlet weak var StarFour: UIButton!
    @IBOutlet weak var StarFive: UIButton!
    
    var showProfile: Doctor!
    var ref: DocumentReference!
    var ref2: DocumentReference!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = showProfile.id!
        ref = Firestore.firestore().collection("doctores").document(id)
        ref2 = Firestore.firestore().collection("usuarios").document(id)
        showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
        print("hola")
    }
    
    func showData(){
        ref.getDocument { (document, error) in
            
            
            self.ref2.getDocument { (docs, err) in
                if let docs = docs {
                    let valUser = docs.data()
                    let name = valUser!["nombre"] as! String
                    let lastname = valUser!["apellido"] as! String
                    self.navbar.title = name + " " + lastname
                    let picture = valUser!["avatar"] as! String
                    
                    if picture != "" {
                        Storage.storage().reference(forURL: picture).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
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
                }
            }
            
            if let document = document {
                let val = document.data()
                let cv = val!["cv"] as! String
                self.txtCV.text = cv
                let specialty = val!["especialidad"] as! String
                self.txtSpecialty.text = specialty
                let idCard = val!["cedula"] as! String
                self.txtIdCard.text = idCard
                var calif = val!["calificacion"] as! String
                let coment = val!["comentario"] as! String
                
                if calif != "" {
                    if calif != "0" {
                        print(calif)
                        print(coment)
                        let op:Int = Int(calif)! / Int(coment)!
                        calif = String(op)
                    }
                    
                    print(calif)
        
                    if calif == "20" {
                       self.StarOne.setTitle("★", for: .normal)
                    }
                    if calif == "30" {
                        self.StarOne.setTitle("★", for: .normal)
                    }
                    if calif == "40" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                    }
                    if calif == "50" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                    }
                    if calif == "60" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                        self.StarThree.setTitle("★", for: .normal)
                    }
                    if calif == "70" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                        self.StarThree.setTitle("★", for: .normal)
                    }
                    if calif == "80" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                        self.StarThree.setTitle("★", for: .normal)
                        self.StarFour.setTitle("★", for: .normal)
                    }
                    if calif == "90" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                        self.StarThree.setTitle("★", for: .normal)
                        self.StarFour.setTitle("★", for: .normal)
                        self.StarFive.setTitle("★", for: .normal)
                    }
                    if calif == "100" {
                        self.StarOne.setTitle("★", for: .normal)
                        self.StarTwo.setTitle("★", for: .normal)
                        self.StarThree.setTitle("★", for: .normal)
                        self.StarFour.setTitle("★", for: .normal)
                        self.StarFive.setTitle("★", for: .normal)
                    }
                }
                
                
                
            } else {
                print("documento no existe")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comentarios" {
            let destiny = segue.destination as! ComentariosDrController
            destiny.showComents = id
        }
    }
    
    @IBAction func btnComents(_ sender: UIButton) {
        performSegue(withIdentifier: "comentarios", sender: self)
    }

    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
    
}
