//
//  SearchController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class BuscarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var buscar: UITextField!
    
    var ref:DocumentReference!
    var getRef:Firestore!
    var listaDoctores = [Doctores]()
    var doctoresFiltro = [Doctores]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        getRef = Firestore.firestore()
        mostrarTodo()
        doctoresFiltro = listaDoctores
    }
    
    func mostrarTodo(){
        
        
        self.getRef.collection("doctores").getDocuments { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
                
                for doctores in result!.documents {
                    let id = doctores.documentID
                    let valDoc = doctores.data()
                    let especialidad = valDoc["especialidad"] as? String
                    
                    
                    self.ref = Firestore.firestore().collection("usuarios").document(id)
                    self.ref.getDocument { (resp, error) in
                        if let error = error {
                                print("se ha producido un error \(error)")
                        } else {
                                
                                if let resp = resp {
                                    let valUser = resp.data()
                                    let avatar = valUser!["avatar"] as? String
                                    let nombre = valUser!["nombre"] as? String
                                    let apellido = valUser!["apellido"] as? String
                                    let doctor = Doctores( id:id, avatar: avatar, cedula: nil, cv: nil, especialidad: especialidad, horario: nil, nombre: nombre, apellido: apellido)
                                    self.doctoresFiltro.append(doctor)
                                    self.listaDoctores.append(doctor)
                                    self.tabla.reloadData()
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
        return doctoresFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorCell
        let doctor: Doctores
        doctor = doctoresFiltro[indexPath.row]
        let nombreCompleto = doctor.nombre! + " " + doctor.apellido!
        cell.nombreDoctor?.text = nombreCompleto
        cell.especialidadDoctor?.text = doctor.especialidad
        
        
        if let urlFoto = doctor.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
                } else {
                    cell.avatarDoctor?.image = UIImage(data: data!)
                    cell.avatarDoctor.layer.masksToBounds = false
                    cell.avatarDoctor.layer.cornerRadius = cell.avatarDoctor.frame.height / 2
                    cell.avatarDoctor.clipsToBounds = true
                    cell.avatarDoctor.layer.borderWidth = 1
                    //self.tabla.reloadData()
                }
            })
        }
        
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
