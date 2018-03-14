//
//  SelectHoursCitesController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class SelecionaHoraController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
