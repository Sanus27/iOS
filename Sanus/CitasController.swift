//
//  CitasController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class CitasController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaCitas = [Citas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        getRef = Firestore.firestore()
        mostrarCitas()
    }
    
    func mostrarCitas(){
        getRef.collection("citas").addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listaCitas.removeAll()
                
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let doctor = val["doctor"] as? String
                    let fecha = val["fecha"] as? String
                    let hora = val["hora"] as? String
                    let usuario = val["usuario"] as? String
                    let hospital = val["hospital"] as? String
                    let cita = Citas(id: id, doctor: doctor, fecha: fecha, hora: hora, hospital: hospital, usuario: usuario)
                    self.listaCitas.append(cita)
                    self.tabla.reloadData()
                }
                
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitasCell
        let cita: Citas
        cita = listaCitas[indexPath.row]
        cell.doctorCitas?.text = cita.doctor
        cell.hospitalCitas?.text = cita.hospital
        cell.fechaCitas?.text = cita.fecha
        cell.horaCitas?.text = cita.hora
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
