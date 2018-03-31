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

class CommentsDrController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var collectionStar: [UIButton]!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var btnComentEditing: UIButton!
    @IBOutlet weak var txtComents: UITextField!
    @IBOutlet weak var txtMensaje: UIView!
    
    public var showComents: String!
    private var ref: DocumentReference!
    private var getRef: Firestore!
    public var listComents = [Comments]()
    private var id = ""
    private var uid = ""
    private var calif = 0
    private var alert = Alerts()
    private var model = ComentariosDrModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtMensaje.isHidden = true
        dataTable.delegate = self
        dataTable.dataSource = self
        txtComents.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        dataTable.estimatedRowHeight = 105
        dataTable.rowHeight = UITableViewAutomaticDimension
        getRef = Firestore.firestore()
        uid = (Auth.auth().currentUser?.uid)!
        id = showComents
        isDoctor()
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
    
    private func newComent(){
        if txtComents.text != "" {
            load.startAnimating()
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let fech = formatter.string(from: date)
            
            let format = DateFormatter()
            format.dateFormat = "HH:mm:ss:SS"
            let hours = format.string(from: date)
            
            let cal:String = String(calif)
            
            self.model.newComent(uid:uid, id:id, coment:txtComents.text!, fech:fech, cal:cal, hours:hours, completionHandler:  { resp in
                if resp == "success" {
                    self.load.stopAnimating()
                    self.model.ratings(data:cal, id:self.id, completionHandler: { result in
                        if result == "success" {
                            
                        }
                    })
                    self.txtComents.text = ""
                    self.txtComents.resignFirstResponder()
                    for button in self.collectionStar {
                        button.setTitle("☆", for: .normal)
                    }
                    self.calif = 0
                } else {
                    self.load.stopAnimating()
                    self.alert.alertSimple(this: self, titileAlert: "Se ha producido un error", bodyAlert: "Se ha producido un error al escribir un nuevo comentario, intentalo mas tarde", actionAlert: nil )
                }
            })
            
        } else {
            
            self.alert.alertSimple(this: self, titileAlert: "Alerta!", bodyAlert: "Para poder enviar el comentario debes escribir algo", actionAlert: nil)
            
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
    
    private func showData(){
        
        self.model.showData( getRef: getRef, idDoctor: id, completionHandler:  { resp in
            self.listComents.removeAll()
            self.listComents = self.model.listComents
            self.dataTable.reloadData()
        })

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
    
    private func isDoctor()  {
        self.model.isDoctor( completionHandler:  { resp in
            if resp == "Medico" { self.txtMensaje.isHidden = true }
            if resp == "Paciente" { self.txtMensaje.isHidden = false }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
