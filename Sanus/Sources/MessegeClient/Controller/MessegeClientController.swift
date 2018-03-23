//
//  PlaticasController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class MessegeClientController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var listenerTextMessage: UITextField!
    @IBOutlet weak var listenerSendMessage: UIButton!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    var listItems = [Message]()
    var ref:DocumentReference!
    var getRef:Firestore!
    var showMessenger: String?
    var idDoctor:String?
    var uid: String?
    var resp: [String:Any] = [:]
    var usuarioMsn: String? = ""
    var doctorMsn: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listItems.removeAll()
        self.tableData.reloadData()
        tableData.delegate = self
        tableData.dataSource = self
        getRef = Firestore.firestore()
        self.idDoctor = showMessenger
        self.uid = Auth.auth().currentUser?.uid
        showData()
        showInfoMessage()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        listenerSendMessage.isEnabled = false;
        listenerSendMessage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
    }
    
    
    @IBAction func listenerMessengerChange(_ sender: UITextField) {
        if (listenerTextMessage.text?.isEmpty)! {
            listenerSendMessage.isEnabled = false;
            listenerSendMessage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
        } else {
            listenerSendMessage.isEnabled = true;
            listenerSendMessage.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
        }
    }
    
    public func showInfoMessage(){
        ref = Firestore.firestore().collection("usuarios").document( self.idDoctor! )
        ref.addSnapshotListener { (document, error) in
            if let document = document {
                let val = document.data()
                let name = val!["nombre"] as! String
                self.navbar.title = name
            }
        }
    }

    

    
    public func showData(){
        
            self.showInfoUser( uid: self.uid, autor: self.uid!, doctor: self.idDoctor!, completionHandler: { resp in
                
                let typeUser = resp["tipo"] as! String
                if typeUser == "Paciente" {
                    self.showMessages( idDoctor:self.idDoctor!, uid:self.uid! )
                }
                if typeUser == "Medico" {
                    self.showMessages( idDoctor:self.uid!, uid:self.idDoctor! )
                }
                
            })
        
    }
    
    private func showMessages( idDoctor:String, uid:String ){
        self.getRef.collection("mensajes").whereField("doctor", isEqualTo: idDoctor ).whereField("usuario", isEqualTo: uid ).order(by: "hora", descending: false).addSnapshotListener { (resp, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                self.listItems.removeAll()
                self.tableData.reloadData()
                
                for docs in resp!.documents {
                    let id = docs.documentID
                    let valMsn = docs.data()
                    let autor = valMsn["autor"] as? String
                    let doctor = valMsn["doctor"] as? String
                    let fecha = valMsn["fecha"] as? String
                    let hora = valMsn["hora"] as? String
                    let usuario = valMsn["usuario"] as? String
                    let mensaje = valMsn["mensaje"] as? String
                    if mensaje != "" {
                        let mess = Message( id:id, autor:autor, doctor:doctor, usuario:usuario, hora:hora, fecha:fecha, mensaje:mensaje )
                        self.listItems.append(mess)
                    }
                    self.tableData.reloadData()
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if listItems[indexPath.row].autor == self.uid {
            let cell: MessageMeCell = tableView.dequeueReusableCell( withIdentifier: "cellMe", for: indexPath ) as! MessageMeCell
            cell.txtMeMessage.text = listItems[indexPath.row].mensaje
            return cell
        } else {
            let cell: MessageDoctorCell = tableView.dequeueReusableCell( withIdentifier: "cellDoctor", for: indexPath ) as! MessageDoctorCell
            cell.txtDoctorMessage.text = listItems[indexPath.row].mensaje
            return cell
        }
        
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
    
    
    public func showInfoUser( uid:String?, autor:String?, doctor:String?, completionHandler: @escaping (([String:Any]) -> Void)) {
        
        ref = Firestore.firestore().collection("usuarios").document( uid! )
        ref.addSnapshotListener { (document, error) in
            if let document = document {
                let val = document.data()
                let typeUser = val!["tipo"] as! String
                
                self.getRef.collection("contactos").whereField("autor", isEqualTo: autor! ).whereField("doctor", isEqualTo: doctor! ).addSnapshotListener { (result, error) in
                    if result!.documents.count != 0 {
                        self.resp = [ "exist": true, "tipo": typeUser ]
                        completionHandler( self.resp )
                    } else {
                        self.resp = [ "exist": false, "tipo": typeUser ]
                        completionHandler( self.resp )
                    }
                }
            }
        }
        
    }
    
    public func addContact( idDoctor:String?, completionHandler: @escaping ((String) -> Void)) {
        
        self.ref = Firestore.firestore().collection("contactos").addDocument(data: [
            "autor": self.uid!,
            "doctor": idDoctor!,
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completionHandler( "error" )
                } else {
                    completionHandler( "Success" )
                }
        }
        
    }
    
    
    @IBAction func btnSendMessage(_ sender: UIButton) {
        self.newMessage()
    }
    
    public func newMessage() {
        if listenerTextMessage.text != nil {
            listenerSendMessage.isEnabled = false
            listenerSendMessage.isHidden = true
            self.load.startAnimating()
        
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let fech = formatter.string(from: date)
        
            let format = DateFormatter()
            format.dateFormat = "hh:mm:ss"
            let hours = format.string(from: date)
            
            self.showInfoUser( uid: self.uid, autor: self.uid!, doctor: self.idDoctor!, completionHandler: { resp in
        
                let typeUser = resp["tipo"] as! String
                if typeUser == "Paciente" {
                    self.insertMsn( autor:self.uid!, doctor:self.idDoctor!, fecha:fech, hora:hours, mensaje:self.listenerTextMessage.text!, usuario:self.uid! )
                }
                if typeUser == "Medico" {
                    self.insertMsn( autor:self.uid!, doctor:self.uid!, fecha:fech, hora:hours, mensaje:self.listenerTextMessage.text!, usuario: self.idDoctor! )
                }
               
                
            })
    
    
        }
        
    }
    
    public func insertMsn( autor:String, doctor:String, fecha:String, hora:String, mensaje:String, usuario:String ){
        if listenerTextMessage.text != nil {
            self.ref = Firestore.firestore().collection("mensajes").addDocument(data: [
                "autor": autor,
                "doctor": doctor,
                "fecha": fecha,
                "hora": hora,
                "mensaje": mensaje,
                "usuario": usuario
            ]) { err in
                if let err = err {
                    self.load.stopAnimating()
                    self.listenerSendMessage.isEnabled = true
                    self.listenerSendMessage.isHidden = false
                    print("Error adding document: \(err)")
                } else {
                    self.load.stopAnimating()
                    self.listenerSendMessage.isEnabled = true
                    self.listenerTextMessage.isHidden = false
                    self.listenerTextMessage.text = ""
        
                self.showInfoUser( uid: self.uid, autor: self.uid!, doctor: self.idDoctor!, completionHandler: { resp in
                    let exist = resp["exist"] as! Bool
                    let typeUser = resp["tipo"] as! String
                    if !exist {
                        if typeUser == "Paciente" {
                            self.addContact( idDoctor: self.idDoctor, completionHandler: { resp in })
                        }
                    }
                    
                    self.load.stopAnimating()
                    self.listenerSendMessage.isHidden = false
                    self.listenerSendMessage.isEnabled = false;
                    self.listenerSendMessage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
                    
                })
        
        
                }
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }


}
