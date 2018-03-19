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

    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    var listItems = [Message]()
    var ref:DocumentReference!
    var getRef:Firestore!
    var showMessenger: String?
    var idDoctor:String?
    var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.delegate = self
        tableData.dataSource = self
        getRef = Firestore.firestore()
        self.idDoctor = showMessenger
        self.uid = Auth.auth().currentUser?.uid
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        showData()
        showInfoMessage()
    }
    
    public func showInfoMessage(){
        ref = Firestore.firestore().collection("usuarios").document( self.idDoctor! )
        ref.addSnapshotListener { (document, error) in
            if let document = document {
                let val = document.data()
                let name = val!["nombre"] as! String
                let lastname = val!["apellido"] as! String
                self.navbar.title = name + " " + lastname
            }
        }
    }
    
    public func showData(){
        self.getRef.collection("mensajes").whereField("doctor", isEqualTo: self.idDoctor! ).getDocuments { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                for doc in result!.documents {
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
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }


}
