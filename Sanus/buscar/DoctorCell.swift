//
//  DoctorCell.swift
//  Sanus
//
//  Created by Luis on 11/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {

    @IBOutlet weak var nombreDoctor: UILabel!
    @IBOutlet weak var avatarDoctor: UIImageView!
    @IBOutlet weak var especialidadDoctor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
