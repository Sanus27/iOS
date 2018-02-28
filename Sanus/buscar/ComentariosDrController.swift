//
//  ComentariosDrController.swift
//  Sanus
//
//  Created by Luis on 08/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ComentariosDrController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    var verComentarios:String!
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaComentarios = [Comentarios]()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        tabla.estimatedRowHeight = 105
        tabla.rowHeight = UITableViewAutomaticDimension
        getRef = Firestore.firestore()
        id = verComentarios
        mostrarComentarios()
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
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func mostrarComentarios(){
        getRef.collection("comentarios").whereField("doctor", isEqualTo: id).getDocuments { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                self.listaComentarios.removeAll()
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let avatar = val["avatar"] as? String
                    let calificacion = val["calificacion"] as? String
                    let doctor = val["doctor"] as? String
                    let autor = val["usuario"] as? String
                    let fecha = val["fecha"] as? String
                    let comentario = val["comentario"] as? String
                    let coments = Comentarios( id: id, comentario: comentario, doctor: doctor, fecha: fecha, usuario: autor, avatar: avatar, calificacion:calificacion )
                    self.listaComentarios.append(coments)
                    self.tabla.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaComentarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComentariosDrCell
        let comentario: Comentarios
        comentario = listaComentarios[indexPath.row]
        cell.usuario.text? = comentario.usuario!
        cell.comentario.text? = comentario.comentario!
        cell.fecha.text? = comentario.fecha!
        if let star_v = comentario.calificacion {
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
        
        
        if let urlFoto = comentario.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
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
    
    func getCalif( data:String? ) {
        
    }
    
    
    
    

}
