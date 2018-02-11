//
//  SearchController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class BuscarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var buscar: UITextField!
    
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaDoctores = [Doctores]()
    var doctoresFiltro = [Doctores]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        getRef = Firestore.firestore()
        mostrarTodo()
        doctoresFiltro = listaDoctores
    }
    
    func mostrarTodo(){
        getRef.collection("doctores").addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.doctoresFiltro.removeAll()
                self.listaDoctores.removeAll()
                
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let avatar = val["avatar"] as? String
                    let nombre = val["nombre"] as? String
                    let especialidad = val["especialidad"] as? String
                    let doctor = Doctores( id:id, avatar: avatar, cedula: nil, cv: nil, especialidad: especialidad, horario: nil, nombre: nombre )
                    self.doctoresFiltro.append(doctor)
                    self.listaDoctores.append(doctor)
                    self.tabla.reloadData()
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctoresFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorCell
        let doctor: Doctores
        doctor = doctoresFiltro[indexPath.row]
        cell.nombreDoctor?.text = doctor.nombre
        cell.especialidadDoctor?.text = doctor.especialidad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "perfil", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "perfil" {
            if let id = tabla.indexPathForSelectedRow {
                let fila = doctoresFiltro[id.row]
                let destino = segue.destination as! PerfilDoctorController
                destino.verPerfil = fila
            }
        }
    }
    
    
    @IBAction func buscador(_ sender: UITextField) {
        
        if buscar.text!.isEmpty {
            
            doctoresFiltro = listaDoctores
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
            return
            
        } else {
           
            doctoresFiltro = listaDoctores.filter({ ( doctor ) -> Bool in
                doctor.especialidad!.lowercased().contains(buscar.text!.lowercased())
            })
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
            return
            
        }
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}
