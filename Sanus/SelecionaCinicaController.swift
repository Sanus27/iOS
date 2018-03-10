//
//  NuevaCitaController.swift
//  Sanus
//
//  Created by Luis on 09/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SelecionaCinicaController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var nextListener: UIButton!
    
    private var ref:DocumentReference!
    private var getRef:Firestore!
    private var listItems = [Hospitals]()
    private var listFilter = [Hospitals]()
    private var selected:NSNumber = 0
    public var idHospital = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.dataSource = self
        tableData.delegate = self
        getRef = Firestore.firestore()
        nextListener.isEnabled = false
        
        nextListener.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5);
        showData()
        listFilter = listItems
    }
    
    private func showData(){
        
        self.getRef.collection("hospitales").addSnapshotListener { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {
    
                    for doc in result!.documents {
                        let id = doc.documentID
                        let valDoc = doc.data()
                        let name = valDoc["nombre"] as? String
                        let address = valDoc["direccion"] as? String
                        let hospital = Hospitals( id: id, address: address, name: name )
                        self.listItems.append(hospital)
                        self.listFilter.append(hospital)
                        self.tableData.reloadData()
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
        let cell = tableData.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HospitalCell
        let hospital: Hospitals
        hospital = listFilter[indexPath.row]
        cell.txtName?.text = hospital.name
        cell.txtAddress?.text = hospital.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = 1
        nextListener.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
        nextListener.isEnabled = true;
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0/255, green: 142/255, blue: 255/255, alpha: 1)
        let fila = listFilter[indexPath.row]
        let idHospital = fila.id!
        let params = ParamsNewAppointment()
        params.setHospital( id: idHospital)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selected = 0
        //UserDefaults.standard.removeObject(forKey: "idHospital")
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.clear
    }

    
    @IBAction func btnSearch(_ sender: UITextField) {
        if txtSearch.text!.isEmpty {
            
            listFilter = listItems
            DispatchQueue.main.async {
                self.tableData.reloadData()
            }
            return
            
        } else {
            
            listFilter = listItems.filter({ ( hospital ) -> Bool in
                hospital.name!.lowercased().contains(txtSearch.text!.lowercased())
            })
            DispatchQueue.main.async {
                self.tableData.reloadData()
            }
            return
            
        }
        
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let next = parent as? PaginacionCitasController
        next?.nextView(index: 0)
    }
    
    @IBAction func btnAtras(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
}
