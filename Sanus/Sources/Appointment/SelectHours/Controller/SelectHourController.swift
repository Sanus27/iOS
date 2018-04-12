//
//  SelectHoursCitesController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
//import Firebase

class SelectHourController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var listenerNext: UIButton!
    //private var ref:DocumentReference!
    //private let model = ParamsNewAppointment()
    private var listItems = [Schedules]()
    //let getRef = Firestore.firestore()
    private let selectHour = SelectHourModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableData.dataSource = self
        tableData.delegate = self
        listenerNext.isEnabled = false
        listenerNext.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5);
        showData()
    }
    
    private func showData(){
        
        self.listItems.removeAll()
        self.tableData.reloadData()
        
        self.selectHour.showData( completionHandler: { resp in
            self.listItems = self.selectHour.listItems
            self.tableData.reloadData()
        })
        
//        let idDoctor = self.model.getDoctor()!
//        let idDay:String = self.model.getDay()!
//
//        getRef.collection("horarios").document(idDoctor).collection( idDay ).addSnapshotListener { (result , error) in
//            if error != nil {
//                print("Se ha producido un error")
//            } else {
//                self.listItems.removeAll()
//                for document in result!.documents {
//                    let valHours = document.data()
//                    let hour = valHours["hora"] as! String
//                    let schedules = Schedules( hour: hour )
//                    self.listItems.append(schedules)
//                    self.tableData.reloadData()
//                }
//            }
//        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SchedulesCell
        let schedules: Schedules
        schedules = listItems[indexPath.row]
        cell.txtSchedules.text = schedules.hour
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listenerNext.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0);
        listenerNext.isEnabled = true;
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0/255, green: 142/255, blue: 255/255, alpha: 1)
        let fila = listItems[indexPath.row]
        let idHour = fila.hour!
        let params = ParamsNewAppointment()
        params.setHour( id: idHour)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.clear
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @IBAction func btnPreview(_ sender: UIButton) {
        let preview = parent as? PaginacionCitasController
        preview?.previewView(index: 3)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let next = parent as? PaginacionCitasController
        next?.nextView(index: 3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
}
