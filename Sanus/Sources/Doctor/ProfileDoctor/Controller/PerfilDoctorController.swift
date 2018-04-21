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
    
    @IBOutlet weak var txtCV: UILabel!
    @IBOutlet weak var txtSpecialty: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtIdCard: UILabel!
    @IBOutlet weak var StarOne: UIButton!
    @IBOutlet weak var StarTwo: UIButton!
    @IBOutlet weak var StarThree: UIButton!
    @IBOutlet weak var StarFour: UIButton!
    @IBOutlet weak var StarFive: UIButton!
    
    
    @IBOutlet weak var txtNameDoctor: UILabel!
    public var showProfile: Doctor!
    private var id = ""
    private var model = PerfilDoctorModel()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.id = showProfile.id!
        showData()
    }
    
    private func showData(){
        self.model.showData( uid: self.id, completionHandler: { resp in
            let name = resp["name"] as? String
            let lastname = resp["lastname"] as? String
            let avatar = resp["avatar"] as? String
            let cv = resp["cv"] as? String
            let specialty = resp["especialidad"] as? String
            let idCard = resp["cedula"] as? String
            let calif = resp["calificacion"] as? String
            
            
            Storage.storage().reference(forURL: avatar!).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
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
            self.txtNameDoctor.text = name! + " " + lastname!
            self.txtCV.text = cv
            self.txtSpecialty.text = specialty
            self.txtIdCard.text = idCard
            
            
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

            
        })


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comentarios" {
            let destiny = segue.destination as! CommentsDrController
            destiny.showComents = self.id
        }
        if segue.identifier == "goMessengePacient" {
            let destiny = segue.destination as! ChatController
            destiny.showMessenger = self.id
        }
    }
    
    @IBAction func btnNewChat(_ sender: UIButton) {
        performSegue(withIdentifier: "goMessengePacient", sender: self)
    }
    
    @IBAction func btnComents(_ sender: UIButton) {
        performSegue(withIdentifier: "comentarios", sender: self)
    }

    @IBAction func btnBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
    
}
