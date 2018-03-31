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

    @IBOutlet weak var table: UITableView!
    private var listItems = [Appointment]()
    private let model = HistoryAppointmentModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        showData()
    }
    
    private func showData(){
        
        self.model.showData(completionHandler: { resp in
            self.listItems.removeAll()
            self.table.reloadData()
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
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
