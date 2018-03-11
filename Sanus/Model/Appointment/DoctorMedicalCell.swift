//
//  DoctorMedicalCell.swift
//  Sanus
//
//  Created by luis on 07/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class DoctorMedicalCell: UITableViewCell {

    @IBOutlet weak var txtEspecialidadMedical: UILabel!
    @IBOutlet weak var txtNameMedical: UILabel!
    @IBOutlet weak var avatarMedical: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
