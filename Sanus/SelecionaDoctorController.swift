//
//  SelectDoctorCitasController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//


import UIKit
import Firebase
import FirebaseStorage

class SelecionaDoctorController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var nextListener: UIButton!
    
    private var ref:DocumentReference!
    private var getRef:Firestore!
    private var listDoctors = [Doctor]()
    private var listFilter = [Doctor]()
    private var selected:NSNumber = 0
    public var idHospital: String? = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableData.delegate = self
        tableData.dataSource = self
        getRef = Firestore.firestore()
        self.listFilter.removeAll()
        self.listDoctors.removeAll()
        nextListener.isEnabled = false
        nextListener.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5);
        self.tableData.reloadData()
        showData()
        listFilter = listDoctors
    }
    
    
    func showData(){
    
        let params = ParamsNewAppointment()
        idHospital = params.getHospital()
        
        print("mostrar data")
        print(idHospital!)
        
        self.getRef.collection("doctores").whereField( "hospital", isEqualTo: idHospital! ).getDocuments { (result, error) in
                if let error = error {
                    print("se ha producido un error \(error)")
                } else {

                    for doc in result!.documents {
                        let id = doc.documentID
                        let valDoc = doc.data()
                        let specialty = valDoc["especialidad"] as? String


                        self.ref = Firestore.firestore().collection("usuarios").document(id)
                        self.ref.addSnapshotListener { (resp, error) in
                            if let error = error {
                                print("se ha producido un error \(error)")
                            } else {

                                if let resp = resp {
                                    let valUser = resp.data()
                                    let avatar = valUser!["avatar"] as? String
                                    let name = valUser!["nombre"] as? String
                                    let lastname = valUser!["apellido"] as? String
                                    let doctor = Doctor( id:id, avatar: avatar, idCard: nil, cv: nil, specialty: specialty, horario: nil, nombre: name, apellido: lastname)
                                    self.listFilter.append(doctor)
                                    self.listDoctors.append(doctor)
                                    self.tableData.reloadData()
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
        return listFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorCell
        let doctor: Doctor
        doctor = listFilter[indexPath.row]
        let fullname = doctor.nombre! + " " + doctor.apellido!
        cell.txtNameMedical?.text = fullname
        cell.txtEspecilidadMedical?.text = doctor.specialty
        
        
        if let urlFoto = doctor.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
                } else {
                    cell.avatarMedical?.image = UIImage(data: data!)
                    cell.avatarMedical.layer.masksToBounds = false
                    cell.avatarMedical.layer.cornerRadius = cell.avatarMedical.frame.height / 2
                    cell.avatarMedical.clipsToBounds = true
                    cell.avatarMedical.layer.borderWidth = 1
                    self.tableData.reloadData()
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = 1
        nextListener.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
        nextListener.isEnabled = true;
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0/255, green: 142/255, blue: 255/255, alpha: 1)
        let fila = listFilter[indexPath.row]
        print("seleccionado: \(fila)")
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selected = 0
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.clear
    }
    
    @IBAction func btnSearch(_ sender: UITextField) {
        
        if txtSearch.text!.isEmpty {
            
            listFilter = listDoctors
            DispatchQueue.main.async {
                self.tableData.reloadData()
            }
            return
            
        } else {
            
            listFilter = listDoctors.filter({ ( doctor ) -> Bool in
                doctor.specialty!.lowercased().contains(txtSearch.text!.lowercased())
            })
            DispatchQueue.main.async {
                self.tableData.reloadData()
            }
            return
            
        }
        
        
    }
    
    @IBAction func btnPreview(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "idHospital")
        let next = parent as? PaginacionCitasController
        next?.previewView(index: 1)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let next = parent as? PaginacionCitasController
        next?.nextView(index: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
}

