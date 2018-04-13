//
//  CitasController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class HistoryAppointmentController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listenerBtnAdd: UIButton!
    @IBOutlet weak var table: UITableView!
    private var listItems = [Appointment]()
    private let model = HistoryAppointmentModel()
    private let modelComent = ComentariosDrModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.listenerBtnAdd.isHidden = true
        showData()
        typeUser()
    }
    
    private func typeUser(){
        self.modelComent.isDoctor(completionHandler: { resp in
            if resp == "Paciente" {
                self.listenerBtnAdd.isHidden = false
            }
        })
    }
    
    private func showData(){
        
        self.listItems.removeAll()
        self.table.reloadData()
        
        self.model.showData(completionHandler: { resp in
            self.listItems = self.model.listItems
            self.table.reloadData()
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitasCell
        let data: Appointment
        data = listItems[indexPath.row]
        cell.doctorCitas?.text = data.doctor
        cell.hospitalCitas?.text = data.hospital
        cell.fechaCitas?.text = data.date
        cell.horaCitas?.text = data.hour
        
        if let urlFoto = data.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
                    cell.avatarCitas?.image = #imageLiteral(resourceName: "user")
                } else {
                    cell.avatarCitas?.image = UIImage(data: data!)
                    cell.avatarCitas.layer.masksToBounds = false
                    cell.avatarCitas.layer.cornerRadius = cell.avatarCitas.frame.height / 2
                    cell.avatarCitas.clipsToBounds = true
                    cell.avatarCitas.layer.borderWidth = 1
                    //self.tableData.reloadData()
                }
            })
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
