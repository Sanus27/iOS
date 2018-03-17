//
//  ComentariosDrController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ComentariosDrController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var collectionStar: [UIButton]!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var btnComentEditing: UIButton!
    @IBOutlet weak var txtComents: UITextField!
    var showComents: String!
    var ref: DocumentReference!
    var ref2: DocumentReference!
    var ref3: Firestore!
    var getRef: Firestore!
    var listComents = [Comments]()
    var id = ""
    var uid = ""
    var calif = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTable.delegate = self
        dataTable.dataSource = self
        txtComents.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        dataTable.estimatedRowHeight = 105
        dataTable.rowHeight = UITableViewAutomaticDimension
        getRef = Firestore.firestore()
        uid = (Auth.auth().currentUser?.uid)!
        id = showComents
        ref = Firestore.firestore().collection("usuarios").document(uid)
        ref2 = Firestore.firestore().collection("doctores").document(id)
        ref3 = Firestore.firestore()
        showData()
    }

    
    @IBAction func comentarioEditing(_ sender: UITextField) {
        let num = Int(txtComents.text!.count);
        if num > 0 {
            btnComentEditing.isEnabled = true
        } else {
            btnComentEditing.isEnabled = false
        }
    }
    
    
    @IBAction func btnNewComent(_ sender: UIButton) {
       newComent()
    }
    
    func newComent(){
        if txtComents.text != "" {
            load.startAnimating()
            let date = Date()
            let hours = date.timeIntervalSinceNow
            let formater = DateFormatter()
            formater.dateStyle = .short
            formater.timeStyle = .none
            let valDate = formater.string(from: date)
            let cal:String = String(calif)
            ref = Firestore.firestore().collection("comentarios").addDocument(data: [
                "usuario": uid,
                "doctor": id,
                "comentario": txtComents.text!,
                "fecha": valDate,
                "calificacion": cal,
                "hora": hours
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.load.stopAnimating()
                } else {
                    self.load.stopAnimating()
                    self.ratings( data: cal )
                    self.txtComents.text = ""
                    self.txtComents.resignFirstResponder()
                    for button in self.collectionStar {
                        button.setTitle("☆", for: .normal)
                    }
                    self.calif = 0
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
            
        } else {
            
            let alerta = UIAlertController(title: "Alerta", message: "Para poder enviar el comentario debes escribir algo", preferredStyle: .alert);
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
            alerta.addAction(aceptar);
            self.present(alerta, animated: true, completion: nil);
            
        }
    }
    
    
    func ratings( data:String ) {
        ref2.getDocument { (document, error) in
            if let document = document {
                let val = document.data()
                let puntaje = val!["calificacion"] as! String
                let comment = val!["comentario"] as! String
                let cedula = val!["cedula"] as! String
                let cv = val!["cv"] as! String
                let especialidad = val!["especialidad"] as! String
                let hospital = val!["hospital"] as! String
                let cal = Int(puntaje)! + Int(data)!
                let com = Int(comment)! + 1
                let data = [ "calificacion": String(cal), "cedula": cedula, "cv":cv, "especialidad": especialidad, "comentario": String(com), "hospital":hospital ]
                self.ref2.setData(data) { (err) in
                    if let err = err?.localizedDescription {
                        print("Se ha producido un error \(err)")
                    } else {
                        //print("Exito al modificar los data")
                    }
                }
            }
        }
    }
    
    @IBAction func starRagting(_ sender: UIButton) {
        let tag = sender.tag
        for button in collectionStar {
            if button.tag <= tag {
                calif = button.tag
                button.setTitle("★", for: .normal)
            } else {
                button.setTitle("☆", for: .normal)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newComent()
        return true
    }
    
    
    @objc func keyboardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: { self.view.layoutIfNeeded() }, completion: nil)
        }
    }
    
    func showData(){
        
        
    
        getRef.collection("comentarios").whereField("doctor", isEqualTo: id).getDocuments { (result , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                for document in result!.documents {
                    let valComen = document.data()
                    let rating = valComen["calificacion"] as? String
                    let user = valComen["usuario"] as? String
                    let date = valComen["fecha"] as? String
                    let comment = valComen["comentario"] as? String
                   
                    
                    
                    self.ref3.collection("usuarios").document(user!).getDocument { (resp, error) in
                        if let error = error {
                            print("se ha producido un error \(error)")
                        } else {

                           if let resp = resp {
                                let valUser = resp.data()
                                var avatar = valUser!["avatar"] as? String
                                let nombre = valUser!["nombre"] as? String
                                let apellido = valUser!["apellido"] as? String
                                let fullname = nombre! + " " + apellido!
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                            
                                let comments = Comments( comment: comment, doctor: fullname, date: date, user: user, avatar: avatar, rating: rating )
                                self.listComents.append(comments)
                                self.dataTable.reloadData()
                            }

                        }
                    }
                    
                    
                    
                    
                }
            }
        }
        
        
        
        
        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listComents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComentariosDrCell
        let comment: Comments
        comment = listComents[indexPath.row]
        cell.usuario.text? = comment.doctor!
        cell.comentario.text? = comment.comment!
        cell.fecha.text? = comment.date!
        if let star_v = comment.rating {
            if(star_v == "20"){
                cell.starUno.setTitle("★", for: .normal)
            }
            if(star_v == "40"){
                cell.starUno.setTitle("★", for: .normal)
                cell.starDos.setTitle("★", for: .normal)
            }
            if(star_v == "60"){
                cell.starUno.setTitle("★", for: .normal)
                cell.starDos.setTitle("★", for: .normal)
                cell.starTres.setTitle("★", for: .normal)
            }
            if(star_v == "80"){
                cell.starUno.setTitle("★", for: .normal)
                cell.starDos.setTitle("★", for: .normal)
                cell.starTres.setTitle("★", for: .normal)
                cell.starCuatro.setTitle("★", for: .normal)
            }
            if(star_v == "100"){
                cell.starUno.setTitle("★", for: .normal)
                cell.starDos.setTitle("★", for: .normal)
                cell.starTres.setTitle("★", for: .normal)
                cell.starCuatro.setTitle("★", for: .normal)
                cell.starCinco.setTitle("★", for: .normal)
            }
        }
        
        
        if let urlFoto = comment.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
                    cell.avatar?.image = #imageLiteral(resourceName: "user")
                } else {
                    cell.avatar?.image = UIImage(data: data!)
                    cell.avatar.layer.masksToBounds = false
                    cell.avatar.layer.cornerRadius = cell.avatar.frame.height / 2
                    cell.avatar.clipsToBounds = true
                    cell.avatar.layer.borderWidth = 1
                }
            })
        }
        
        return cell
    }

    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
