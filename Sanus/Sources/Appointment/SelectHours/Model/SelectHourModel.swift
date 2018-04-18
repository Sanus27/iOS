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
                    let itemHours = valHours["hora"] as! String
                    print("itemHours")
                    print(itemHours)
                    print(" ")
                    //let schedules = Schedules( hour: itemHours )
                    //self.listItems.append(schedules)
                    //completionHandler( self.listItems )
                    
                    
                    
                    
                    self.getRef.collection("citas-ocupadas").document(idDoctor).collection("hora").addSnapshotListener { (resp , erro) in
                        if erro != nil {
                            print("Se ha producido un error")
                        } else {
                            
                            print( resp!.count )
                            if resp!.count == 0 {
                                let schedules = Schedules( hour: itemHours )
                                self.listItems.append(schedules)
                                completionHandler( self.listItems )
                            } else {
                                
                                if result!.count == resp!.count {
                                    completionHandler( self.listItems )
                                } else {
                                    
                                    for docs in resp!.documents {
                                        let valSchedules = docs.data()
                                        let itemSchedules = valSchedules["hora"] as! String
                                    
                                        if itemHours != itemSchedules {
                                            let schedules = Schedules( hour: itemHours )
                                            self.listItems.append(schedules)
                                            completionHandler( self.listItems )
                                        }
                                    
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        
    }

    

}
