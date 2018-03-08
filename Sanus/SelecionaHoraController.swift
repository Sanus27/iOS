//
//  SelectHoursCitesController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SelecionaHoraController: UIViewController {

    @IBOutlet weak var selectDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectDate.datePickerMode = .time
    }
    
    @IBAction func btnDate(_ sender: UIDatePicker) {
        let dataFormater = DateFormatter()
        dataFormater.dateFormat = "hh:mm a"
        print(dataFormater.string(from: selectDate.date))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
