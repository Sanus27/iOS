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
    var verComentarios:String!
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaComentarios = [Comentarios]()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        getRef = Firestore.firestore()
        id = verComentarios
        mostrarComentarios()
    }
    
    func mostrarComentarios(){
        getRef.collection("comentarios").whereField("doctor", isEqualTo: id).addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                self.listaComentarios.removeAll()
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let avatar = val["avatar"] as? String
                    let doctor = val["doctor"] as? String
                    let autor = val["usuario"] as? String
                    let fecha = val["fecha"] as? String
                    let comentario = val["comentario"] as? String
                    let coments = Comentarios(id: id, comentario: comentario, doctor: doctor, fecha: fecha, usuario: autor, avatar: avatar)
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
                    //self.tabla.reloadData()
                }
            })
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 135
    }

    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    


}
