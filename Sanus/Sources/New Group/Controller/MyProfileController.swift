//
//  MyProfileController.swift
//  Sanus
//
//  Created by luis on 17/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class MyProfileController: UIViewController {

    @IBOutlet weak var cv: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var txtIdCard: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var StarOne: UIButton!
    @IBOutlet weak var StarTwo: UIButton!
    @IBOutlet weak var StarThree: UIButton!
    @IBOutlet weak var StarFour: UIButton!
    @IBOutlet weak var StarFive: UIButton!
    
    
    
    private var uid: String?
    var ref: DocumentReference!
    var ref2: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = (Auth.auth().currentUser?.uid)!
        showData()
    }

    public func showData(){
        self.ref = Firestore.firestore().collection("doctores").document( self.uid! )
        self.ref.getDocument { (document, error) in
            if let document = document {
                let valDoctor = document.data()
                let cv = valDoctor!["cv"] as! String
                let idCard = valDoctor!["cedula"] as! String
                let speciality = valDoctor!["especialidad"] as! String
                var calif = valDoctor!["calificacion"] as! String
                let coment = valDoctor!["comentario"] as! String
                
                self.ref2 = Firestore.firestore().collection("usuarios").document( self.uid! )
                self.ref2.getDocument { (doc, error) in
                    if let doc = doc {
                        let valUser = doc.data()
                        var avatar = valUser!["avatar"] as? String
                        
                        
                        if avatar != nil {
                            avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
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
                        } else {
                            self.avatar?.image = #imageLiteral(resourceName: "user")
                        }
                        
                        self.txtIdCard.text = idCard
                        self.doctor.text = speciality
                        self.cv.text = cv
                        
                        if calif != "" {
                            if calif != "0" {
                                let op:Int = Int(calif)! / Int(coment)!
                                calif = String(op)
                            }
                            
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
                    }
                }
                
            }
        }
    }
    
    @IBAction func btnComents(_ sender: UIButton) {
        performSegue(withIdentifier: "goComents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goComents" {
            let destiny = segue.destination as! ComentariosDrController
            destiny.showComents = self.uid
        }
    }

}
