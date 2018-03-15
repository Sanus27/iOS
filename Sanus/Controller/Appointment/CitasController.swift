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

    @IBOutlet weak var table: UITableView!
    var ref:DocumentReference!
    var getRef:Firestore!
    var listItems = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getRef = Firestore.firestore()
        showData()
    }
    
    func showData(){
        getRef.collection("citas").addSnapshotListener { (resp , error) in
            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listItems.removeAll()
                
                for document in resp!.documents {
                    let id = document.documentID
                    let val = document.data()
                    let doctor = val["doctor"] as? String
                    let date = val["fecha"] as? String
                    let hour = val["hora"] as? String
                    let user = val["usuario"] as? String
                    let hospital = val["hospital"] as? String
                    //var avatar = val["avatar"] as? String
                    //avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                    let appointment = Appointment(id: id, doctor: doctor, date: date, hour: hour, hospital: hospital, user: user)
                    self.listItems.append(appointment)
                    self.table.reloadData()
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
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitasCell
        let data: Appointment
        data = listItems[indexPath.row]
        cell.doctorCitas?.text = data.doctor
        cell.hospitalCitas?.text = data.hospital
        cell.fechaCitas?.text = data.date
        cell.horaCitas?.text = data.hour
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
