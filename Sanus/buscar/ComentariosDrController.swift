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
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaComentarios = [Comentarios]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        getRef = Firestore.firestore()
        mostrarComentarios()
    }
    
    func mostrarComentarios(){
        getRef.collection("comentarios").whereField("doctor", isEqualTo: "OTYMy6HA1EPTrQHzuV3E").addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                self.listaComentarios.removeAll()
                for document in resp!.documents {
                    let val = document.data()
                    let doctor = val["doctor"] as? String
                    let autor = val["usuario"] as? String
                    let fecha = val["fecha"] as? String
                    let comentario = val["comentario"] as? String
                    let coments = Comentarios(comentario: comentario, doctor: doctor, fecha: fecha, usuario: autor)
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
        cell.fecha.text? = comentario.fecha!
        cell.comentario.text? = comentario.comentario!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    

    @IBAction func btnAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }


}
