//
//  SelectHoursCitesController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SelectHourController: UIViewController {
    
    @IBOutlet weak var listenerNext: UIButton!
    private var ref:DocumentReference!
    private let model = ParamsNewAppointment()
    private var listItems = [Any]()
    let getRef = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
                for document in result!.documents {
                    let valHours = document.data()
                    let data = valHours["data"] as Any
                    self.listItems.append(data)
                }
                
            }

        }
        
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
