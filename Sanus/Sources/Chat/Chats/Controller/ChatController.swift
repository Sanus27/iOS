//
//  PlaticasController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
    var userType: String = ""
    private let modelC = ComentariosDrModel()
    private let model = MessegeClientModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.delegate = self
        tableData.dataSource = self
        getRef = Firestore.firestore()
        self.idDoctor = showMessenger
        self.uid = Auth.auth().currentUser?.uid
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        listenerSendMessage.isEnabled = false;
        listenerSendMessage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
        verifyDidUserType()
        showData()
        showInfoMessage()
    }
    
    func verifyDidUserType(){
        self.modelC.isDoctor( completionHandler:  { resp in
            if resp == "Medico" { self.userType = "Medico" }
            if resp == "Paciente" { self.userType = "Paciente" }
        })
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
        self.model.showInfoMessage(idDoctor: self.idDoctor!, completionHandler:  { resp in
            self.navbar.title = resp
        })
    }
    
    
   
    public func showData(){
        
        self.modelC.isDoctor( completionHandler:  { resp in
            if resp == "Medico" { self.showMessages( idDoctor:self.uid!, uid:self.idDoctor! ) }
            if resp == "Paciente" { self.showMessages( idDoctor:self.idDoctor!, uid:self.uid! ) }
        })
        
    }
    
    public func showMessages( idDoctor:String, uid:String ){
    
        self.getRef.collection("mensajes").whereField("doctor", isEqualTo: idDoctor ).whereField("usuario", isEqualTo: uid ).order(by: "hora", descending: false ).addSnapshotListener { (resp, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                self.listItems.removeAll()
                self.tableData.reloadData()
                for doc in resp!.documents {
                    let id = doc.documentID
                    let val = doc.data()
                    let autor = val["autor"] as? String
                    let doctor = val["doctor"] as? String
                    let fecha = val["fecha"] as? String
                    let hora = val["hora"] as? String
                    let usuario = val["usuario"] as? String
                    let mensaje = val["mensaje"] as? String
                    let mess = Message( id:id, autor:autor!, doctor:doctor!, usuario:usuario!, hora:hora!, fecha:fecha!, mensaje:mensaje! )
                    self.listItems.append(mess)
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
    
    
    
    @IBAction func btnSendMessage(_ sender: UIButton) {
  
        listenerSendMessage.isEnabled = false
        listenerTextMessage.isHidden = true
        self.load.startAnimating()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let fech = formatter.string(from: date)
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss:SS"
        let hours = format.string(from: date)
        
        if self.userType == "Paciente" {
            self.insertMsn( autor:self.uid!, doctor:self.idDoctor!, fecha:fech, hora:hours, mensaje:self.listenerTextMessage.text!, usuario:self.uid! )
        } else {
            self.insertMsn( autor:self.uid!, doctor:self.uid!, fecha:fech, hora:hours, mensaje:self.listenerTextMessage.text!, usuario: self.idDoctor! )
        }
        
        
    }
    
    public func insertMsn( autor:String, doctor:String, fecha:String, hora:String, mensaje:String, usuario:String ){
        
        self.model.addMsn( getRef:getRef, autor: autor, doctor: doctor, fecha: fecha, hora: hora, mensaje: mensaje, usuario: usuario, completionHandler: { resp in
            if resp == "error" {
                self.load.stopAnimating()
                self.listenerSendMessage.isEnabled = true
                self.listenerSendMessage.isHidden = false
            }
            if resp == "Success"{
                print("resp")
                print(resp)
                self.load.stopAnimating()
                self.listenerSendMessage.isEnabled = true
                self.listenerTextMessage.isHidden = false
                self.listenerTextMessage.text = ""
                
//                self.modelC.isDoctor( completionHandler:  { resp in
//                    if resp == "Medico" { self.showMessages( idDoctor:self.uid!, uid:self.idDoctor! ) }
//                    if resp == "Paciente" { self.showMessages( idDoctor:self.idDoctor!, uid:self.uid! ) }
//                })
                
                
                
                self.load.stopAnimating()
                self.listenerSendMessage.isHidden = false
                self.listenerSendMessage.isEnabled = false;
                self.listenerSendMessage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3);
            }
        })
        
        
        
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }


}
