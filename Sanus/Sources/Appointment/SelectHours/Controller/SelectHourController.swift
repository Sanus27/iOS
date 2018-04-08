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
        //let idDoctor = self.model.getDoctor()!
        //let idDay:String = self.model.getCalendar()!

        //let daySelect = getDayOfWeek( today:idDay )
        //print(daySelect)
        //print( daySelect )
//        ref = Firestore.firestore().collection("horarios").document( idDoctor )
//        ref.getDocument { (document, error) in
//
//            if let document = document{
//                let val = document.data()
//                let lunes = val!["lunes"]
//                let martes = val!["martes"]
//                let miercoles = val!["miercoles"]
//                let jueves = val!["jueves"]
//                let viernes = val!["viernes"]
//
//                //print("lunes")
//                //print(lunes!)
//
//                //print("martes")
//                //print(martes!)
//
//                //print("miercoles")
//                //print(miercoles!)
//
//                //print("jueves")
//                //print(jueves!)
//
//                //print("viernes")
//                //print(viernes!)
//
//
//            } else {
//                print("error:", error!)
//            }
//
//        }
    }
    
    func getDayOfWeek( today:Date ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_EC")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let dateString:String = (String(describing: dateFormatter.string(from: today) ))
        let dateArr = dateString.components(separatedBy: " ")
        return dateArr[0]
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
