//
//  SelectHoursCitesController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SelectHourController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var listenerNext: UIButton!
    private var ref:DocumentReference!
    private let model = ParamsNewAppointment()
    private var listItems = [Schedules]()
    let getRef = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.dataSource = self
        tableData.delegate = self
        listenerNext.isEnabled = false
        listenerNext.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
    
    private func showData(){
        
        let idDoctor = self.model.getDoctor()!
        let idDay:String = self.model.getDay()!

        getRef.collection("horarios").whereField("doctor", isEqualTo: idDoctor).whereField("dia", isEqualTo: idDay).addSnapshotListener { (result , error) in

            if let error = error {
                print("hay un error en firebase", error)
            } else {
                
                self.listItems.removeAll()
                for document in result!.documents {
                    let valHours = document.data()
                    let data = valHours["data"] as! [String]
                    for i in 0...data.count - 1 {
                        let schedules = Schedules( hour: data[i] )
                        self.listItems.append(schedules)
                        self.tableData.reloadData()
                    }
                }
                
            }

        }
        
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
