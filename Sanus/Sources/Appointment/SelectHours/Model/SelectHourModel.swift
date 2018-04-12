//
//  SelectHourModel.swift
//  Sanus
//
//  Created by luis on 12/04/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class SelectHourModel: UIViewController {

    public var listItems = [Schedules]()
    private let getRef = Firestore.firestore()
    private let model = ParamsNewAppointment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func showData( completionHandler: @escaping (([Schedules]) -> Void)) {
        
        let idDoctor = self.model.getDoctor()!
        let idDay:String = self.model.getDay()!
        
        getRef.collection("horarios").document(idDoctor).collection( idDay ).addSnapshotListener { (result , error) in
            if error != nil {
                print("Se ha producido un error")
            } else {
                
                self.listItems.removeAll()
                for document in result!.documents {
                    let valHours = document.data()
                    let hour = valHours["hora"] as! String
                    let schedules = Schedules( hour: hour )
                    self.listItems.append(schedules)
                    completionHandler( self.listItems )
                }
            }
        }
        
    }

    

}
